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
using System.IO;
using System.Text;

using DotnetPark.NLucene.Index;

namespace DotnetPark.NLucene.Search
{
	///<summary> A Query that matches documents within an exclusive range. </summary>
	public class RangeQuery : Query
	{
		private Term lowerTerm;
		private Term upperTerm;
		private bool inclusive;
		private IndexReader reader;
		private BooleanQuery query;
    
		///<summary> Constructs a query selecting all terms greater than 
		/// <c>lowerTerm</c> but less than <c>upperTerm</c>.
		/// There must be at least one term and either term may be null--
		/// in which case there is no bound on that side, but if there are 
		/// two term, both terms <b>must</b> be for the same field.
		///</summary>
		public RangeQuery(Term lowerTerm, Term upperTerm, bool inclusive)
		{
			if (lowerTerm == null && upperTerm == null)
			{
				throw new ArgumentException("At least one term must be non-null");
			}
			if (lowerTerm != null && upperTerm != null && lowerTerm.Field != upperTerm.Field)
			{
				throw new ArgumentException("Both terms must be for the same field");
			}
			this.lowerTerm = lowerTerm;
			this.upperTerm = upperTerm;
			this.inclusive = inclusive;
		}
    
		/// <summary>
		/// [To be supplied.]
		/// </summary>
		public override void Prepare(IndexReader reader)
		{
			this.query = null;
			this.reader = reader;
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
    
		/// <summary>
		/// [To be supplied.]
		/// </summary>
		/// <returns>[To be supplied.]</returns>
		private BooleanQuery GetQuery()
		{
			if (query == null)
			{
				BooleanQuery q = new BooleanQuery();
				// if we have a lowerTerm, start there. otherwise, start at beginning
				if (lowerTerm == null) lowerTerm = new Term(GetField(), "");
				ITermEnum enm = reader.Terms(lowerTerm);
				try
				{
					string lowerText = null;
					//string field;
					bool checkLower = false;
					if (!inclusive) // make adjustments to set to exclusive
					{
						if (lowerTerm != null)
						{
							lowerText = lowerTerm.Text;
							checkLower = true;
						}
						if (upperTerm != null)
						{
							// set upperTerm to an actual term in the index
							ITermEnum uppEnum = reader.Terms(upperTerm);
							upperTerm = uppEnum.Term();
						}
					}
					string testField = GetField();
					do
					{
						Term term = enm.Term();
						if (term != null && term.Field == testField)
						{
							if (!checkLower || term.Text.CompareTo(lowerText) > 0) 
							{
								checkLower = false;
								if (upperTerm != null)
								{
									int compare = upperTerm.CompareTo(term);
									/* if beyond the upper term, or is exclusive and
									 * this is equal to the upper term, break out */
									if ((compare < 0) || (!inclusive && compare == 0)) break;
								}
								TermQuery tq = new TermQuery(term);	  // found a match
								tq.Boost = boost;               // set the boost
								q.Add(tq, false, false);		  // add to q
							}
						} 
						else
						{
							break;
						}
					}
					while (enm.Next());
				} 
				finally
				{
					enm.Close();
				}
				query = q;
			}
			return query;
		}
    
		private string GetField()
		{
			return (lowerTerm != null ? lowerTerm.Field : upperTerm.Field);
		}
    
		///<summary> Prints a user-readable version of this query. </summary>
		public override string ToString(string field)
		{
			StringBuilder buffer = new StringBuilder();
			if (!GetField().Equals(field))
			{
				buffer.Append(GetField());
				buffer.Append(":");
			}
			buffer.Append(inclusive ? "[" : "{");
			buffer.Append(lowerTerm != null ? lowerTerm.Text : "null");
			buffer.Append("-");
			buffer.Append(upperTerm != null ? upperTerm.Text : "null");
			buffer.Append(inclusive ? "]" : "}");
			if (boost != 1.0f)
			{
				buffer.Append("^");
				buffer.Append(boost);
			}
			return buffer.ToString();
		}
	}
}
