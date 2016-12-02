/* ====================================================================
 * The Apache Software License, Version 1.1
 *
 * Copyright (c) 2001 The Apache Software Foundation.  All rights
 * reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *
 * 3. The end-user documentation included with the redistribution,
 *    if any, must include the following acknowledgment:
 *       "This product includes software developed by the
 *        Apache Software Foundation (http://www.apache.org/)."
 *    Alternately, this acknowledgment may appear in the software itself,
 *    if and wherever such third-party acknowledgments normally appear.
 *
 * 4. The names "Apache" and "Apache Software Foundation" and
 *    "Apache Lucene" must not be used to endorse or promote products
 *    derived from this software without prior written permission. For
 *    written permission, please contact apache@apache.org.
 *
 * 5. Products derived from this software may not be called "Apache",
 *    "Apache Lucene", nor may "Apache" appear in their name, without
 *    prior written permission of the Apache Software Foundation.
 *
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESSED OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED.  IN NO EVENT SHALL THE APACHE SOFTWARE FOUNDATION OR
 * ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
 * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals on behalf of the Apache Software Foundation.  For more
 * information on the Apache Software Foundation, please see
 * <http://www.apache.org/>.
 */

using System;

using DotnetPark.NLucene.Index;
using DotnetPark.NLucene.Documents;
using DotnetPark.NLucene.Store;

namespace DotnetPark.NLucene.Search
{
	///<summary>
	///Implements search over a set of <c>Searchers</c>.
	///</summary>
	public class MultiSearcher : Searcher 
	{
		private Searcher[] searchers;
		private int[] starts;
		private int maxDoc = 0;

		///<summary> Creates a searcher which searches <i>searchers</i>. </summary>
		public MultiSearcher(Searcher[] searchers) 
		{
			this.searchers = searchers;

			starts = new int[searchers.Length + 1];	  // build starts array
			for (int i = 0; i < searchers.Length; i++) 
			{
				starts[i] = maxDoc;
				maxDoc += searchers[i].MaxDoc();		  // compute maxDocs
			}
			starts[searchers.Length] = maxDoc;
		}

		///<summary> Frees resources associated with this <c>Searcher</c>. </summary>
		public override void Close() 
		{
			for (int i = 0; i < searchers.Length; i++)
				searchers[i].Close();
		}

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		public override int DocFreq(Term term) 
		{
			int docFreq = 0;
			for (int i = 0; i < searchers.Length; i++)
				docFreq += searchers[i].DocFreq(term);
			return docFreq;
		}

		///<summary> For use by HitCollector implementations. </summary>
		public override Document Doc(int n) 
		{
			int i = SearcherIndex(n);			  // find searcher index
			return searchers[i].Doc(n - starts[i]);	  // dispatch to searcher
		}

		///<summary>
		/// For use by HitCollector implementations to identify the
		/// index of the sub-searcher that a particular hit came from.
		/// </summary>
		public int SearcherIndex(int n) 
		{	  // find searcher for doc n:
			// replace w/ call to Arrays.binarySearch in Java 1.2
			int lo = 0;					  // search starts array
			int hi = searchers.Length - 1;		  // for first element less
			// than n, return its index
			while (hi >= lo) 
			{
				int mid = (lo + hi) >> 1;
				int midValue = starts[mid];
				if (n < midValue)
					hi = mid - 1;
				else if (n > midValue)
					lo = mid + 1;
				else
					return mid;
			}
			return hi;
		}

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		/// <returns>[To be supplied.]</returns>
		public override int MaxDoc() 
		{
			return maxDoc;
		}

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		public override TopDocs Search(Query query, Filter filter, int nDocs)
		{
			HitQueue hq = new HitQueue(nDocs);
			float minScore = 0.0f;
			int totalHits = 0;

			for (int i = 0; i < searchers.Length; i++) 
			{  // search each searcher
				TopDocs docs = searchers[i].Search(query, filter, nDocs);
				totalHits += docs.TotalHits;		  // update totalHits
				ScoreDoc[] scoreDocs = docs.ScoreDocs;
				for (int j = 0; j < scoreDocs.Length; j++) 
				{ // merge scoreDocs into hq
					ScoreDoc scoreDoc = scoreDocs[j];
					if (scoreDoc.Score >= minScore) 
					{
						scoreDoc.Doc += starts[i];		  // convert doc
						hq.Put(scoreDoc);			  // update hit queue
						if (hq.Size() > nDocs) 
						{		  // if hit queue overfull
							hq.Pop();				  // remove lowest in hit queue
							minScore = ((ScoreDoc)hq.Top()).Score; // reset minScore
						}
					} 
					else
						break;				  // no more scores > minScore
				}
			}

			ScoreDoc[] scoreDocs1 = new ScoreDoc[hq.Size()];
			for (int i = hq.Size()-1; i >= 0; i--)	  // put docs in array
				scoreDocs1[i] = (ScoreDoc)hq.Pop();

			return new TopDocs(totalHits, scoreDocs1);
		}


		/// <summary>
		/// [To be supplied.]
		/// </summary>
		public class MultiHitCollector :HitCollector
		{
			/// <summary>
			/// [To be supplied.]
			/// </summary>
			public HitCollector results;

			/// <summary>
			/// [To be supplied.]
			/// </summary>
			public int start;

			/// <summary>
			/// [To be supplied.]
			/// </summary>
			public MultiHitCollector()
			{
			}

			/// <summary>
			/// [To be supplied.]
			/// </summary>
			/// <param name="doc">[To be supplied.]</param>
			/// <param name="score">[To be supplied.]</param>
			public override void Collect(int doc, float score)
			{
				results.Collect(doc + start, score);
			}
		}


		///<summary> Lower-level search API.
		///
		/// <p>HitCollector.Collect(int,float) is called for every non-zero
		/// scoring document.</p>
		///
		/// <p>Applications should only use this if they need <i>all</i> of the
		/// matching documents.  The high-level search API (
		/// Searcher.Search(Query)) is usually more efficient, as it skips
		/// non-high-scoring hits.</p>
		///</summary>
		///<param name="query">To match documents.</param>
		///<param name="filter">If non-null, a bitset used to eliminate some documents.</param>
		///<param name="results">Results to receive hits.</param>
		public override void Search(Query query, Filter filter,
			HitCollector results)
		{
			for (int i = 0; i < searchers.Length; i++) 
			{

				int start = starts[i];
				MultiHitCollector mhc = new MultiHitCollector();
				mhc.results = results;
				mhc.start = start;
				searchers[i].Search(query, filter, mhc);
			}
		}
	}
}
