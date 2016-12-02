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
using System.IO;

using DotnetPark.NLucene.Analysis;
using DotnetPark.NLucene.Search;
using DotnetPark.NLucene.Index;

namespace DotnetPark.NLucene.QueryParser
{
	/// <summary>
	/// Contains routines that used bu QueryParser.
	/// </summary>
	public class QueryParserBase
	{
		/// <summary> Internal constant. </summary>
		protected const int CONJ_NONE   = 0;
		/// <summary> Internal constant. </summary>
		protected const int CONJ_AND    = 1;
		/// <summary> Internal constant. </summary>
		protected const int CONJ_OR     = 2;

		/// <summary> Internal constant. </summary>
		protected const int MOD_NONE    = 0;
		/// <summary> Internal constant. </summary>
		protected const int MOD_NOT     = 10;
		/// <summary> Internal constant. </summary>
		protected const int MOD_REQ     = 11;

		private int phraseSlop = 0;

		/// <summary>
		/// Gets or sets a phrase slop value.
		/// </summary>
		public int PhraseSlop
		{
			get { return phraseSlop; }
			set { phraseSlop = value; }
		}

		/// <summary>
		/// Adds the next parsed clause.
		/// </summary>
		protected void AddClause(ArrayList clauses, int conj, int mods, Query q) 
		{
			bool required, prohibited;

			// If this term is introduced by AND, make the preceding term required,
			// unless it's already prohibited
			if (conj == CONJ_AND) 
			{
				BooleanClause c = (BooleanClause) clauses[clauses.Count-1];
				if (!c.Prohibited)
					c.Required = true;
			}

			// We might have been passed a null query; the term might have been
			// filtered away by the analyzer. 
			if (q == null)
				return;

			// We set REQUIRED if we're introduced by AND or +; PROHIBITED if
			// introduced by NOT or -; make sure not to set both.
			prohibited = (mods == MOD_NOT);
			required = (mods == MOD_REQ);
			if (conj == CONJ_AND && !prohibited)
				required = true;
			clauses.Add(new BooleanClause(q, required, prohibited));
		}

		/// <summary>
		/// Returns a query for the specified field.
		/// </summary>
		protected Query GetFieldQuery(string field, Analyzer analyzer, string queryText) 
		{
			// Use the analyzer to get all the tokens, and then build a TermQuery,
			// PhraseQuery, or nothing based on the term count

			TokenStream source = analyzer.TokenStream(field,
				new StringReader(queryText));
			ArrayList v = new ArrayList();
			NLucene.Analysis.Token t;

			while (true) 
			{
				try 
				{
					t = source.Next();
				}
				catch (IOException) 
				{
					t = null;
				}
				if (t == null)
					break;
				v.Add(t.TermText);
			}
			if (v.Count == 0)
				return null;
			else if (v.Count == 1)
				return new TermQuery(new Term(field, (string)v[0]));
			else 
			{
				PhraseQuery q = new PhraseQuery();
				q.Slop = phraseSlop;
				foreach(string text in v)
				{
					q.Add(new Term(field, text));
				}
				return q;
			}
		}

		/// <summary>
		/// Returns a range query.
		/// </summary>
		protected Query GetRangeQuery(string field, Analyzer analyzer,
			string queryText, bool inclusive)
		{
			// Use the analyzer to get all the tokens.  There should be 1 or 2.
			TokenStream source = analyzer.TokenStream(field,
				new StringReader(queryText));
			Term[] terms = new Term[2];
			NLucene.Analysis.Token t;

			for (int i = 0; i < 2; i++)
			{
				try
				{
					t = source.Next();
				}
				catch (IOException)
				{
					t = null;
				}
				if (t != null)
				{
					string text = t.TermText;
					if (text.ToUpper() != "NULL")
					{
						terms[i] = new Term(field, text);
					}
				}
			}
			return new RangeQuery(terms[0], terms[1], inclusive);
		}
	}
}
