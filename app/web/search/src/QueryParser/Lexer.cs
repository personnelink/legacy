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
using System.Collections;

namespace DotnetPark.NLucene.QueryParser
{
	/// <summary>
	/// A simple Lexer that is used by QueryParser.
	/// </summary>
	internal class Lexer
	{
		private TokenList tokens;
		private CharReader reader;

		/// <summary>
		/// Initializes a new instance of the Lexer class with the specified
		/// query to lex.
		/// </summary>
		/// <param name="query">A query to lex.</param>
		public Lexer(string query)
			: this(new StringReader(query))
		{
			// use this
		}

		/// <summary>
		/// Initializes a new instance of the Lexer class with the specified
		/// TextReader to lex.
		/// </summary>
		/// <param name="source">A TextReader to lex.</param>
		public Lexer(TextReader source)
		{
			// token queue
			tokens = new TokenList();

			// read the file contents
			reader = new CharReader(source);
		}

		/// <summary>
		/// Breaks the input stream onto the tokens list and returns it.
		/// </summary>
		/// <returns>The tokens list.</returns>
		public TokenList Lex()
		{
			Token token = GetNextToken();
			while(true)
			{
				if(token != null)
					tokens.Add(token);
				else
				{
					tokens.Add(new Token(TokenTypes.EOF));
					return tokens;
				}

				token = GetNextToken();
			}
		}

		private Token GetNextToken()
		{
			while(!reader.Eos())
			{
				char ch = reader.GetNext();

				// skipping whitespaces
				if(Char.IsWhiteSpace(ch))
				{
					continue;
				}
				switch(ch)
				{
					case '+':
						return new Token(ch.ToString(), TokenTypes.PLUS);
					case '-':
						return new Token(ch.ToString(), TokenTypes.MINUS);
					case '(':
						return new Token(ch.ToString(), TokenTypes.LPAREN);
					case ')':
						return new Token(ch.ToString(), TokenTypes.RPAREN);
					case ':':
						return new Token(ch.ToString(), TokenTypes.COLON);
					case '!':
						return new Token(ch.ToString(), TokenTypes.NOT);
					case '^':
						return new Token(ch.ToString(), TokenTypes.CARAT);
					case '~':
						if(Char.IsDigit(reader.Peek()))
						{
							string number = ReadIntegerNumber();
							return new Token(ch.ToString() + number, TokenTypes.SLOP);
						}
						else
						{
							return new Token(ch.ToString(), TokenTypes.FUZZY);
						}
					case '"':
						return ReadQuoted(ch);
					case '[':
						return ReadInclusiveRange(ch);
					case '{':
						return ReadExclusiveRange(ch);
					case ']':
					case '}':
					case '*':
						throw new ParserException(String.Format("Unrecognized char '{0}' at {1}.", ch, reader.Column));
					default:
						return ReadTerm(ch);
						
				} // end of swith

			}
			return null;
		}

		// Reads an integer number
		private string ReadIntegerNumber()
		{
			string number = "";
			while(!reader.Eos() && Char.IsDigit(reader.Peek()))
			{
				number += reader.GetNext();
			}
			return number;
		}

		// Reads an inclusive range like [some words]
		private Token ReadInclusiveRange(char ch)
		{
			string range = ch.ToString();
			while(!reader.Eos())
			{
				ch = reader.GetNext();
				range += ch.ToString();

				if(ch == ']')
					return new Token(range, TokenTypes.RANGEIN);
			}
			throw new ParserException("Unterminated inclusive range!");
		}

		// Reads an exclusive range like {some words}
		private Token ReadExclusiveRange(char ch)
		{
			string range = ch.ToString();
			while(!reader.Eos())
			{
				ch = reader.GetNext();
				range += ch.ToString();

				if(ch == '}')
					return new Token(range, TokenTypes.RANGEEX);
			}
			throw new ParserException("Unterminated exclusive range!");
		}

		// Reads quoted string like "something else"
		private Token ReadQuoted(char ch)
		{
			string quoted = ch.ToString();
			while(!reader.Eos())
			{
				ch = reader.GetNext();
				quoted += ch.ToString();

				if(ch == '"')
					return new Token(quoted, TokenTypes.QUOTED);
			}
			throw new ParserException("Unterminated string!");
		}

		private Token ReadTerm(char ch)
		{
			bool completed = false;
			int asteriskCount = 0;
			bool hasQuestion = false;

			string val = "";

			while(true)
			{
				switch(ch)
				{
					case '\\':
						val += ReadEscape(ch);
						break;
					case '*':
						asteriskCount++;
						val += ch.ToString();
						break;
					case '?':
						hasQuestion = true;
						val += ch.ToString();
						break;
					case '\n':
					case '\t':
					case ' ':
					case '+':
					case '-':
					case '!':
					case '(':
					case ')':
					case ':':
					case '^':
					case '[':
					case ']':
					case '{':
					case '}':
					case '"':
					case '~':
						// create new Token
						reader.UnGet();
						completed = true;
						break;
					default:
						val += ch.ToString();
						break;
				} // end of switch

				if(completed || reader.Eos())
					break;
				else
					ch = reader.GetNext();
			}

			// create new Token
			if(hasQuestion)
				return new Token(val, TokenTypes.WILDTERM);

			else if(asteriskCount == 1 && val[val.Length - 1] == '*')
				return new Token(val, TokenTypes.PREFIXTERM);

			else if(asteriskCount > 0)
				return new Token(val, TokenTypes.WILDTERM);

			else if(val.ToUpper() == "AND" || val == "&&")
				return new Token(val, TokenTypes.AND);

			else if(val.ToUpper() == "OR" || val == "||")
				return new Token(val, TokenTypes.OR);

			else if(val.ToUpper() == "NOT")
				return new Token(val, TokenTypes.NOT);

			else if(val.ToLower().CompareTo(val.ToUpper()) == 0)
				return new Token(val, TokenTypes.NUMBER);

			else
				return new Token(val, TokenTypes.TERM);
		}

		private string ReadEscape(char ch)
		{
			string val = ch.ToString();
			ch = reader.GetNext();

			int idx = ch.ToString().IndexOfAny(new char[] {'\\', '+', '-', '!', '(', ')',
					':', '^', '[', ']', '{', '}', '"', '~', '*'});

			if(idx == 0)
			{
				val += ch.ToString();
				return val;
			}
			throw new ParserException("Unrecognized escape sequence at " + reader.Column);
		}
	}
}
