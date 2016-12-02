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
using System.Globalization;

using DotnetPark.NLucene.Analysis;
using DotnetPark.NLucene.Index;
using DotnetPark.NLucene.Search;

namespace DotnetPark.NLucene.QueryParser
{
	/// <summary>
	/// <p>It's a query parser.
	/// The only method that clients should need to call is Parse().
	/// The syntax for query strings is as follows:
	/// A Query is a series of clauses. A clause may be prefixed by:</p>
	/// <ul>
	///	<li>a plus (+) or a minus (-) sign, indicating that the 
	///	clause is required or prohibited respectively; or</li>
	///	<li>a term followed by a colon, indicating the field to be searched.
	///	This enables one to construct queries which search multiple fields.</li>
	///	</ul>
	///	<p>
	///	A clause may be either:</p>
	///	<ul>
	///	<li>a term, indicating all the documents that contain this term; or</li>
	///	<li>a nested query, enclosed in parentheses. Note that this may be 
	///	used with a +/- prefix to require any of a set of terms.</li>
	///	</ul>
	///	<p>
	/// Thus, in BNF, the query grammar is:</p>
	///	<code>
	///	Query  ::= ( Clause )*
	///	Clause ::= ["+", "-"] [&lt;TERM&gt; ":"] ( &lt;TERM&gt; | "(" Query ")" )
	///	</code>
	///	<p>
	///	Examples of appropriately formatted queries can be found in the test cases.
	///	</p>
	/// </summary>
	public class QueryParser : QueryParserBase
	{
		private Analyzer analyzer;
		private string field;
		private TokenList tokens;

		/// <summary>
		/// Initializes a new instance of the QueryParser class with a specified field and
		/// analyzer values.
		/// </summary>
		/// <param name="field">The default field for query terms.</param>
		/// <param name="analyzer">Used to find terms in the query text.</param>
		public QueryParser(string field, Analyzer analyzer) 
		{
			this.analyzer = analyzer;
			this.field = field;
		}

		/// <summary>
		/// Returns a new instance of the QueryParser class with a specified query, field and
		/// analyzer values.
		/// </summary>
		/// <param name="query">The query to parse.</param>
		/// <param name="field">The default field for query terms.</param>
		/// <param name="analyzer">Used to find terms in the query text.</param>
		/// <returns></returns>
		static public Query Parse(string query, string field, Analyzer analyzer)
		{
			QueryParser parser = new QueryParser(field, analyzer);
			return parser.Parse(query);
		}

		/// <summary>
		/// Returns a parsed Query instance.
		/// </summary>
		/// <param name="query">The query value to be parsed.</param>
		/// <returns>A parsed Query instance.</returns>
		public Query Parse(string query)
		{
			return this.Parse(new StringReader(query));
		}

		/// <summary>
		/// Returns a parsed Query instance.
		/// </summary>
		/// <param name="reader">The TextReader value to be parsed.</param>
		/// <returns>A parsed Query instance.</returns>
		public Query Parse(TextReader reader)
		{
			Lexer lexer = new Lexer(reader);
			tokens = lexer.Lex();

			return MatchQuery(field);
		}

		// matches for CONJUNCTION
		// CONJUNCTION ::= <AND> | <OR>
		private int MatchConjunction()
		{
			switch(tokens.Peek().Type)
			{
				case TokenTypes.AND:
							tokens.Extract();
							return CONJ_AND;
				case TokenTypes.OR:
							tokens.Extract();
							return CONJ_OR;
				default:
					return CONJ_NONE;
			}
		}

		// matches for MODIFIER
		// MODIFIER ::= <PLUS> | <MINUS> | <NOT>
		private int MatchModifier()
		{
			switch(tokens.Peek().Type)
			{
				case TokenTypes.PLUS:
							tokens.Extract();
							return MOD_REQ;
				case TokenTypes.MINUS:
				case TokenTypes.NOT:
							tokens.Extract();
							return MOD_NOT;
				default:
							return MOD_NONE;
			}
		}


		// matches for QUERY
		// QUERY ::= [MODIFIER] CLAUSE (<CONJUNCTION> [MODIFIER] CLAUSE)*
		private Query MatchQuery(string field)
		{
			ArrayList clauses = new ArrayList();
			Query q, firstQuery = null;
			int mods = MOD_NONE;
			int conj = CONJ_NONE;

			mods = MatchModifier();

			// match for CLAUSE
			q = MatchClause(field);
			AddClause(clauses, CONJ_NONE, mods, q);
			if(mods == MOD_NONE)
				firstQuery = q;

			// match for CLAUSE*
			while(true)
			{
				if(tokens.Peek().Type == TokenTypes.EOF)
				{
					MatchToken(TokenTypes.EOF);
					break;
				}

				if(tokens.Peek().Type == TokenTypes.RPAREN)
				{
					//MatchToken(TokenTypes.RPAREN);
					break;
				}

				conj = MatchConjunction();

				mods = MatchModifier();
				q = MatchClause(field);
				AddClause(clauses, conj, mods, q);
			}

			// finalize query
			if(clauses.Count == 1 && firstQuery != null)
			{
				return firstQuery;
			} 
			else 
			{
				BooleanQuery query = new BooleanQuery();
				foreach(BooleanClause clause in clauses)
				{
					query.Add(clause);
				}
				return query;
			}
		}

		// matches for CLAUSE
		// CLAUSE ::= [TERM <COLON>] ( TERM | (<LPAREN> QUERY <RPAREN>))
		private Query MatchClause(string field)
		{
			Query q = null;
			//Token tokenField = null;
			
			// match for [TERM <COLON>]
			Token term = tokens.Extract();
			if(term.Type == TokenTypes.TERM && 
				tokens.Peek().Type == TokenTypes.COLON)
			{
				MatchToken(TokenTypes.COLON);
				field = term.Value;
			} 
			else
			{
				tokens.Push(term);
			}

			// match for
			// TERM | (<LPAREN> QUERY <RPAREN>)
			if(tokens.Peek().Type == TokenTypes.LPAREN)
			{
				MatchToken(TokenTypes.LPAREN);
				q = MatchQuery(field);
				MatchToken(TokenTypes.RPAREN);
			} 
			else 
			{
				q = MatchTerm(field);
			}

			return q;
		}

		// matches for TERM
		// TERM ::= TERM | PREFIXTERM | WILDTERM | NUMBER
		//			[ <FUZZY> ] [ <CARAT> <NUMBER> [<FUZZY>]]
		//
		//			| (<RANGEIN> | <RANGEEX>) [<CARAT> <NUMBER>]
		//			| <QUOTED> [SLOP] [<CARAT> <NUMBER>]
		private Query MatchTerm(string field)
		{
			Token term = null;
			Token slop = null;
			Token boost = null;
			bool prefix = false;
			bool wildcard = false;
			bool fuzzy = false;
			bool rangein = false;
			Query q = null;

			term = tokens.Extract();
			switch(term.Type)
			{
				case TokenTypes.TERM:
				case TokenTypes.NUMBER:
				case TokenTypes.PREFIXTERM:
				case TokenTypes.WILDTERM:
					if(term.Type == TokenTypes.PREFIXTERM)
						prefix = true;
					else if(term.Type == TokenTypes.WILDTERM)
						wildcard = true;

					if(tokens.Peek().Type == TokenTypes.FUZZY)
					{
						MatchToken(TokenTypes.FUZZY);
						fuzzy = true;
					}
					if(tokens.Peek().Type == TokenTypes.CARAT)
					{
						MatchToken(TokenTypes.CARAT);
						boost = MatchToken(TokenTypes.NUMBER);

						if(tokens.Peek().Type == TokenTypes.FUZZY)
						{
							MatchToken(TokenTypes.FUZZY);
							fuzzy = true;
						}
					}
					// compile production
					if(wildcard)
						q = new WildcardQuery(new Term(field, term.Value));
					else if(prefix)
						q = new PrefixQuery(new Term(field, 
								term.Value.Substring(0, term.Value.Length - 1)));
					else if(fuzzy)
						q = new FuzzyQuery(new Term(field, term.Value));
					else
						q = GetFieldQuery(field, analyzer, term.Value);

					break;

				case TokenTypes.RANGEIN:
				case TokenTypes.RANGEEX:
					if(term.Type == TokenTypes.RANGEIN)
						rangein = true;

					if(tokens.Peek().Type == TokenTypes.CARAT)
					{
						MatchToken(TokenTypes.CARAT);
						boost = MatchToken(TokenTypes.NUMBER);
					}

					q = GetRangeQuery(field, analyzer,
							term.Value.Substring(1, term.Value.Length - 1), rangein);
					break;

				case TokenTypes.QUOTED:
					if(tokens.Peek().Type == TokenTypes.SLOP)
					{
						slop = MatchToken(TokenTypes.SLOP);
					}
					if(tokens.Peek().Type == TokenTypes.CARAT)
					{
						MatchToken(TokenTypes.CARAT);
						boost = MatchToken(TokenTypes.NUMBER);
					}

					q = GetFieldQuery(field, analyzer,
							term.Value.Substring(1, term.Value.Length - 1));
					if(slop != null && q is PhraseQuery)
					{
						try
						{
							int s = Int32.Parse(slop.Value.Substring(1));
							((PhraseQuery)q).Slop = s;
						}
						catch
						{
							// ignored
						}
					}
					break;
			} // end of switch

			if(boost != null)
			{
				float f = 1.0F;
				try
				{
					f = Single.Parse(boost.Value, NumberFormatInfo.InvariantInfo);
				}
				catch
				{
					// ignored
				}
				q.Boost = f;
			}

			return q;
		}

		// matches for token of the specified type and returns it
		// otherwise Exception throws
		private Token MatchToken(TokenTypes expectedType)
		{
			if(tokens.Count == 0)
			{
				throw new ParserException("Error: UnExpected End of Program");
			}

			Token t = tokens.Extract();
			if (expectedType != t.Type)
			{
				throw new ParserException("Error: Unexpected Token:" + t.Type.ToString()  + ", expected:" + expectedType.ToString());
			}
			//Console.WriteLine(t);
			return t;
		}
	}
}
