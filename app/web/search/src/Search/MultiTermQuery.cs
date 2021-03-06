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
using System.IO;

using DotnetPark.NLucene.Index;

namespace DotnetPark.NLucene.Search
{
	///<summary>
	/// A Query that matches documents containing a subset of terms provided
	/// by a FilteredTermEnum enumeration.
	/// <p>
	/// <c>MultiTermQuery</c> is not designed to be used by itself.
	/// <br/>
	/// The reason being that it is not intialized with a FilteredTermEnum
	/// enumeration. A FilteredTermEnum enumeration needs to be provided.</p>
	/// <p>
	/// For example, WildcardQuery and FuzzyQuery extend
	/// <c>MultiTermQuery</c> to provide WildcardTermEnum and
	/// FuzzyTermEnum, respectively.</p>
	///</summary>
	public class MultiTermQuery : Query 
	{
		private Term term;
		private FilteredTermEnum enm;
		//private IndexReader reader;
		private BooleanQuery query;
    
		///<summary> Enable or disable lucene style toString(field) format </summary>
		private const bool LUCENE_STYLE_TOSTRING = false;
    
		///<summary> Constructs a query for terms matching <c>term</c>. </summary>
		public MultiTermQuery(Term term) 
		{
			this.term = term;
			this.query = query;
		}
    
		///<summary> Set the TermEnum to be used. </summary>
		protected void SetEnum(FilteredTermEnum enm) 
		{
			this.enm = enm;
		}
    
		/// <summary>
		/// [To be supplied.]
		/// </summary>
		public override float SumOfSquaredWeights(Searcher searcher) 
		{
			return GetQuery().SumOfSquaredWeights(searcher);
		}
    
		/// <summary>
		/// [To be supplied.]
		/// </summary>
		/// <param name="norm">[To be supplied.]</param>
		public override void Normalize(float norm) 
		{
			try 
			{
				GetQuery().Normalize(norm);
			} 
			catch (IOException e) 
			{
				throw new Exception(e.ToString());
			}
		}
    
		/// <summary>
		/// [To be supplied.]
		/// </summary>
		/// <param name="reader">[To be supplied.]</param>
		/// <returns>[To be supplied.]</returns>
		public override Scorer Scorer(IndexReader reader) 
		{
			return GetQuery().Scorer(reader);
		}
    
		private BooleanQuery GetQuery() 
		{
			if (query == null) 
			{
				BooleanQuery q = new BooleanQuery();
				try 
				{
					do 
					{
						Term t = enm.Term();
						if (t != null) 
						{
							TermQuery tq = new TermQuery(t);	// found a match
							tq.Boost = boost * enm.Difference(); // set the boost
							q.Add(tq, false, false);		// add to q
						}
					} while (enm.Next());
				} 
				finally 
				{
					enm.Close();
				}
				query = q;
			}
			return query;
		}
    
		///<summary> Prints a user-readable version of this query. </summary>
		public override string ToString(string field) 
		{
			if (!LUCENE_STYLE_TOSTRING) 
			{
				Query q = null;
				try 
				{
					q = GetQuery();
				} 
				catch (Exception)
				{
					//
				}
				if (q != null) 
				{
					return "(" + q.ToString(field) + ")";
				}
			}
			StringBuilder buffer = new StringBuilder();
			if (!term.Field.Equals(field)) 
			{
				buffer.Append(term.Field);
				buffer.Append(":");
			}
			buffer.Append(term.Text);
			if (boost != 1.0f) 
			{
				buffer.Append("^");
				buffer.Append(boost);
			}
			return buffer.ToString();
		}
	}
}
