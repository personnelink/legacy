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
using System.IO;

using DotnetPark.NLucene.Index;

namespace DotnetPark.NLucene.Search
{
	///<summary>
	///A Query that matches documents containing terms with a specified prefix.
	///</summary>
	public class PrefixQuery : Query 
	{
		private Term prefix;
		private IndexReader reader;
		private BooleanQuery query;

		///<summary>
		/// Constructs a query for terms starting with <c>prefix</c>.
		///</summary>
		public PrefixQuery(Term prefix) 
		{
			this.prefix = prefix;
			this.reader = reader;
		}

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		/// <param name="reader">[To be supplied.]</param>
		public override void Prepare(IndexReader reader) 
		{
			this.query = null;
			this.reader = reader;
		}

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		/// <param name="searcher">[To be supplied.]</param>
		/// <returns>[To be supplied.]</returns>
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

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		/// <returns>[To be supplied.]</returns>
		private BooleanQuery GetQuery() 
		{
			if (query == null) 
			{
				BooleanQuery q = new BooleanQuery();
				ITermEnum enm = reader.Terms(prefix);
				try 
				{
					string prefixText = prefix.Text;
					string prefixField = prefix.Field;
					do 
					{
						Term term = enm.Term();
						if (term != null &&
							term.Text.StartsWith(prefixText) &&
							term.Field == prefixField) 
						{
							TermQuery tq = new TermQuery(term);	  // found a match
							tq.Boost = boost;			  // set the boost
							q.Add(tq, false, false);		  // add to q
							//System.out.println("added " + term);
						} 
						else 
						{
							break;
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
			StringBuilder buffer = new StringBuilder();
			if (!prefix.Field.Equals(field)) 
			{
				buffer.Append(prefix.Field);
				buffer.Append(":");
			}
			buffer.Append(prefix.Text);
			buffer.Append('*');
			if (boost != 1.0f) 
			{
				buffer.Append("^");
				buffer.Append(boost);
			}
			return buffer.ToString();
		}
	}
}
