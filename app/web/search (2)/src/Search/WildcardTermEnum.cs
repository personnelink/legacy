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

namespace DotnetPark.NLucene.Search
{
	///<summary>
	/// <p>Subclass of FilteredTermEnum for enumerating all terms that match the
	/// specified wildcard filter term.</p>
	/// <p>
	/// Term enumerations are always ordered by Term.CompareTo().  Each term in
	/// the enumeration is greater than all that precede it.</p>
	///</summary>
	public class WildcardTermEnum : FilteredTermEnum 
	{
		Term searchTerm;
		string field = "";
		string text = "";
		string pre = "";
		int preLen = 0;
		//bool fieldMatch = false;
		bool endEnum = false;

		///<summary> Creates new WildcardTermEnum </summary>
		public WildcardTermEnum(IndexReader reader, Term term) : base(reader, term)
		{
																   
			searchTerm = term;
			field = searchTerm.Field;
			text = searchTerm.Text;

			int sidx = text.IndexOf(WILDCARD_STRING);
			int cidx = text.IndexOf(WILDCARD_CHAR);
			int idx = sidx;
			if (idx == -1) idx = cidx;
			else if (cidx >= 0) idx = Math.Min(idx, cidx);

			pre = searchTerm.Text.Substring(0,idx);
			preLen = pre.Length;
			text = text.Substring(preLen);
			SetEnum(reader.Terms(new Term(searchTerm.Field, pre)));
		}

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		/// <param name="term">[To be supplied.]</param>
		/// <returns>[To be supplied.]</returns>
		public override bool TermCompare(Term term) 
		{
			if (field == term.Field) 
			{
				string searchText = term.Text;
				if (searchText.StartsWith(pre)) 
				{
					return WildcardEquals(text, 0, searchText, preLen);
				}
			}
			endEnum = true;
			return false;
		}

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		/// <returns>[To be supplied.]</returns>
		public override float Difference() 
		{
			return 1.0f;
		}

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		/// <returns>[To be supplied.]</returns>
		public override bool EndEnum() 
		{
			return endEnum;
		}

		//*******************************************
		// string equality with support for wildcards
		//*******************************************

		/// <summary> [To be supplied.] </summary>
		public const char WILDCARD_STRING = '*';
		/// <summary> [To be supplied.] </summary>
		public const char WILDCARD_CHAR = '?';

		///<summary>
		/// Determines if a word matches a wildcard pattern.
		/// <small>Work released by Granta Design Ltd after originally being done on
		/// company time.</small>
		///</summary>
		public static bool WildcardEquals(string pattern, int patternIdx,
			string str, int stringIdx)
		{
			for (int p = patternIdx; ; ++p)
			{
				for (int s = stringIdx; ; ++p, ++s)
				{
					// End of string yet?
					bool sEnd = (s >= str.Length);
					// End of pattern yet?
					bool pEnd = (p >= pattern.Length);

					// If we're looking at the end of the string...
					if (sEnd)
					{
						// Assume the only thing left on the pattern is/are wildcards
						bool justWildcardsLeft = true;

						// Current wildcard position
						int wildcardSearchPos = p;
						// While we haven't found the end of the pattern,
						// and haven't encountered any non-wildcard characters
						while (wildcardSearchPos < pattern.Length && justWildcardsLeft)
						{
							// Check the character at the current position
							char wildchar = pattern[wildcardSearchPos];
							// If it's not a wildcard character, then there is more
							// pattern information after this/these wildcards.

							if (wildchar != WILDCARD_CHAR &&
								wildchar != WILDCARD_STRING)
							{
								justWildcardsLeft = false;
							}
							else
							{
								// Look at the next character
								wildcardSearchPos++;
							}
						}

						// This was a prefix wildcard search, and we've matched, so
						// return true.
						if (justWildcardsLeft)
						{
							return true;
						}
					}

					// If we've gone past the end of the string, or the pattern,
					// return false.
					if (sEnd || pEnd)
					{
						break;
					}

					// Match a single character, so continue.
					if (pattern[p] == WILDCARD_CHAR)
					{
						continue;
					}

					//
					if (pattern[p] == WILDCARD_STRING)
					{
						// Look at the character beyond the '*'.
						++p;
						// Examine the string, starting at the last character.
						for (int i = str.Length; i >= s; --i)
						{
							if (WildcardEquals(pattern, p, str, i))
							{
								return true;
							}
						}
						break;
					}
					if (pattern[p] != str[s])
					{
						break;
					}
				}
				return false;
			}
		}

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		public override void Close()
		{
			base.Close();
			searchTerm = null;
			field = null;
			text = null;
		}
	}
}
