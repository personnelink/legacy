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
using System.Text;
using System.Collections;

using DotnetPark.NLucene.Index;

namespace DotnetPark.NLucene.Search
{
	///<summary>
	///A Query that matches documents containing a particular sequence of terms.
	///This may be combined with other terms with a BooleanQuery.
	///</summary>
	public class PhraseQuery : Query 
	{
		private string field;
		private ArrayList terms = new ArrayList();
		private float idf = 0.0f;
		private float weight = 0.0f;

		private int slop = 0;


		///<summary> Constructs an empty phrase query. </summary>
		public PhraseQuery() 
		{
		}

		///<summary>
		///<p>Gets or sets the number of other words permitted between words in query phrase.
		///If zero, then this is an exact phrase search.  For larger values this works
		///like a <c>WITHIN</c> or <c>NEAR</c> operator.</p>
		///
		///<p>The slop is in fact an edit-distance, where the units correspond to
		///moves of terms in the query phrase out of position.  For example, to switch
		///the order of two words requires two moves (the first move places the words
		///atop one another), so to permit re-orderings of phrases, the slop must be
		///at least two.</p>
		///
		///<p>More exact matches are scored higher than sloppier matches, thus search
		///results are sorted by exactness.</p>
		///
		///<p>The slop is zero by default, requiring exact matches.</p></summary>
		public int Slop
		{
			get { return slop; }
			set { slop = value; }
		}

		///<summary> Adds a term to the end of the query phrase. </summary>
		public void Add(Term term) 
		{
			if (terms.Count == 0)
				field = term.Field;
			else if (term.Field != field)
				throw new ArgumentException
					("All phrase terms must be in the same field: " + term);

			terms.Add(term);
		}

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		/// <param name="searcher">[To be supplied.]</param>
		/// <returns>[To be supplied.]</returns>
		public override float SumOfSquaredWeights(Searcher searcher) 
		{
			for (int i = 0; i < terms.Count; i++)	  // sum term IDFs
				idf += Similarity.Idf((Term)terms[i], searcher);

			weight = idf * boost;
			return weight * weight;			  // square term weights
		}

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		/// <param name="norm">[To be supplied.]</param>
		public override void Normalize(float norm) 
		{
			weight *= norm;				  // normalize for query
			weight *= idf;				  // factor from document
		}

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		/// <param name="reader">[To be supplied.]</param>
		/// <returns>[To be supplied.]</returns>
		public override Scorer Scorer(IndexReader reader) 
		{
			if (terms.Count == 0)			  // optimize zero-term case
				return null;
			if (terms.Count == 1) 
			{			  // optimize one-term case
				Term term = (Term)terms[0];
				ITermDocs docs = reader.TermDocs(term);
				if (docs == null)
					return null;
				return new TermScorer(docs, reader.Norms(term.Field), weight);
			}

			ITermPositions[] tps = new ITermPositions[terms.Count];
			for (int i = 0; i < terms.Count; i++) 
			{
				ITermPositions p = reader.TermPositions((Term)terms[i]);
				if (p == null)
					return null;
				tps[i] = p;
			}

			if (slop == 0)				  // optimize exact case
				return new ExactPhraseScorer(tps, reader.Norms(field), weight);
			else
				return
					new SloppyPhraseScorer(tps, slop, reader.Norms(field), weight);

		}

		///<summary> Prints a user-readable version of this query. </summary>
		public override string ToString(string f) 
		{
			StringBuilder buffer = new StringBuilder();
			if (!field.Equals(f)) 
			{
				buffer.Append(field);
				buffer.Append(":");
			}

			buffer.Append("\"");
			for (int i = 0; i < terms.Count; i++) 
			{
				buffer.Append(((Term)terms[i]).Text);
				if (i != terms.Count-1)
					buffer.Append(" ");
			}
			buffer.Append("\"");

			if (slop != 0) 
			{
				buffer.Append("~");
				buffer.Append(slop);
			}

			if (boost != 1.0f) 
			{
				buffer.Append("^");
				buffer.Append(boost);
			}

			return buffer.ToString();
		}
	}
}
