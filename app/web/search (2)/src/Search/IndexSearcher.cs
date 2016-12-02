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
using System.Collections;

using DotnetPark.NLucene.Index;
using DotnetPark.NLucene.Documents;
using DotnetPark.NLucene.Store;

namespace DotnetPark.NLucene.Search
{
	///<summary>
	/// Implements search over a single IndexReader.
	///</summary>
	public class IndexSearcher : Searcher 
	{
		IndexReader reader;

		///<summary> Creates a searcher searching the index in the named directory. </summary>
		public IndexSearcher(String path) 
			: this(IndexReader.Open(path))
		{
			// use this
		}
    
		///<summary> Creates a searcher searching the index in the provided directory. </summary>
		public IndexSearcher(Directory directory) 
			: this(IndexReader.Open(directory))
		{
			// use this
		}
    
		///<summary>Creates a searcher searching the provided index.</summary>
		public IndexSearcher(IndexReader r) 
		{
			reader = r;
		}
    
		///<summary> Frees resources associated with this Searcher. </summary>
		public override void Close() 
		{
			reader.Close();
		}

		/// <summary>
		/// Returns a DocFreq.
		/// </summary>
		public override int DocFreq(Term term) 
		{
			return reader.DocFreq(term);
		}

		///<summary> For use by HitCollector implementations. </summary>
		public override Document Doc(int i) 
		{
			return reader.Document(i);
		}

		/// <summary>
		/// Returns a MAxDoc value.
		/// </summary>
		public override int MaxDoc() 
		{
			return reader.MaxDoc();
		}

		/// <summary>
		/// Internal class.
		/// </summary>
		internal class IndexHitCollector : HitCollector
		{
			private float minScore = 0.0f;
			public BitArray bits;
			public int[] totalHits;
			public HitQueue hq;
			public int nDocs;

			/// <summary>
			/// Initializes a new instance of the IndexHitCollector class.
			/// </summary>
			public IndexHitCollector()
			{

			}

			/// <summary>
			/// [To be supplied.]
			/// </summary>
			public override void Collect(int doc, float score)
			{
				if (score > 0.0f &&			  // ignore zeroed buckets
					(bits==null || bits[doc])) 
				{	  // skip docs not in bits
					totalHits[0]++;
					if (score >= minScore) 
					{
						hq.Put(new ScoreDoc(doc, score));	  // update hit queue
						if (hq.Size() > nDocs) 
						{		  // if hit queue overfull
							hq.Pop();			  // remove lowest in hit queue
							minScore = ((ScoreDoc)hq.Top()).Score; // reset minScore
						}
					}
				}
			}
		}

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		/// <param name="query">[To be supplied.]</param>
		/// <param name="filter">[To be supplied.]</param>
		/// <param name="nDocs">[To be supplied.]</param>
		/// <returns>[To be supplied.]</returns>
		public override TopDocs Search(Query query, Filter filter, int nDocs)
		{
			Scorer scorer = Query.Scorer(query, this, reader);
			if (scorer == null)
				return new TopDocs(0, new ScoreDoc[0]);

			BitArray bits = filter != null ? filter.Bits(reader) : null;
			HitQueue hq = new HitQueue(nDocs);
			int[] totalHits = new int[1];

			IndexHitCollector ihc = new IndexHitCollector();
			ihc.bits = bits;
			ihc.totalHits = totalHits;
			ihc.hq = hq;
			ihc.nDocs = nDocs;

			scorer.Score(ihc, reader.MaxDoc());

			ScoreDoc[] scoreDocs = new ScoreDoc[hq.Size()];
			for (int i = hq.Size()-1; i >= 0; i--)	  // put docs in array
				scoreDocs[i] = (ScoreDoc)hq.Pop();
    
			return new TopDocs(totalHits[0], scoreDocs);
		}

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		protected class IndexHitCollector2 : HitCollector
		{
			/// <summary>
			/// [To be supplied.]
			/// </summary>
			public BitArray bits;

			/// <summary>
			/// [To be supplied.]
			/// </summary>
			public HitCollector results;

			/// <summary>
			/// [To be supplied.]
			/// </summary>
			/// <param name="bits">[To be supplied.]</param>
			/// <param name="results">[To be supplied.]</param>
			public IndexHitCollector2(BitArray bits, HitCollector results)
			{

			}

			/// <summary>
			/// [To be supplied.]
			/// </summary>
			/// <param name="doc">[To be supplied.]</param>
			/// <param name="score">[To be supplied.]</param>
			public override void Collect(int doc, float score)
			{
				if (bits[doc]) 
				{		  // skip docs not in bits
					results.Collect(doc, score);
				}
			}
		}

		///<summary>
		/// Lower-level search API.
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
		///<param name="results">To receive hits.</param>
		public override void Search(Query query, Filter filter,
			HitCollector results) 
		{
			HitCollector collector = results;
			if (filter != null) 
			{
				BitArray bits = filter.Bits(reader);

				collector = new IndexHitCollector2(bits, results);

				Scorer scorer = Query.Scorer(query, this, reader);
				if (scorer == null)
					return;
				scorer.Score(collector, reader.MaxDoc());
			}

		}
	}
}