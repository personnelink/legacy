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

namespace DotnetPark.NLucene.Analysis.De
{
	/// <summary>
	/// A stemmer for German words.
	/// </summary>
	public class GermanStemmer 
	{
		///<summary>
		/// Buffer for the terms while stemming them.
		///</summary>
		private StringBuilder sb = new StringBuilder();

		///<summary>
		/// Indicates if a term is handled as a noun.
		///</summary>
		private bool uppercase = false;

		///<summary>
		/// Amount of characters that are removed with <tt>substitute()</tt> while stemming.
		///</summary>
		private int substCount = 0;

		/// <summary>
		/// Initializes a new instance of the GermanStemmer class.
		/// </summary>
		public GermanStemmer() 
		{
		}

		///<summary>
		/// Stemms the given term to an unique <tt>discriminator</tt>.
		///
		/// @param term  The term that should be stemmed.
		/// @return      Discriminator for <tt>term</tt>
		///</summary>
		public String stem( String term ) 
		{
			if ( !isStemmable( term ) ) 
			{
				return term;
			}
			// Mark a possible noun.
			if ( Char.IsUpper( term[0] ) ) 
			{
				uppercase = true;
			}
			else 
			{
				uppercase = false;
			}
			// Use lowercase for medium stemming.
			term = term.ToLower();
			// Reset the StringBuffer.
			sb.Remove( 0, sb.Length );
			sb.Insert( 0, term );
			sb = substitute( sb );
			// Nouns have only seven possible suffixes.
			if ( uppercase && sb.Length > 3 ) 
			{
				if ( sb.ToString( sb.Length - 3, sb.Length ).Equals( "ern" ) ) 
				{
					sb.Remove( sb.Length - 3, sb.Length );
				}
				else if ( sb.ToString( sb.Length - 2, sb.Length ).Equals( "en" ) ) 
				{
					sb.Remove( sb.Length - 2, sb.Length );
				}
				else if ( sb.ToString( sb.Length - 2, sb.Length ).Equals( "er" ) ) 
				{
					sb.Remove( sb.Length - 2, sb.Length );
				}
				else if ( sb.ToString( sb.Length - 2, sb.Length ).Equals( "es" ) ) 
				{
					sb.Remove( sb.Length - 2, sb.Length );
				}
				else if ( sb[sb.Length - 1 ] == 'e' ) 
				{
					sb.Remove( sb.Length - 1, 1 );
				}
				else if ( sb[sb.Length - 1] == 'n' ) 
				{
					sb.Remove( sb.Length - 1, 1 );
				}
				else if ( sb[sb.Length - 1] == 's' ) 
				{
					sb.Remove( sb.Length - 1, 1 );
				}
				// Additional step for female plurals of professions and inhabitants.
				if ( sb.Length > 5 && sb.ToString( sb.Length - 3, sb.Length ).Equals( "erin*" ) ) 
				{
					sb.Remove( sb.Length -1, 1 );
				}
				// Additional step for irregular plural nouns like "Matrizen -> Matrix".
				if ( sb[sb.Length - 1] == ( 'z' ) ) 
				{
					sb[sb.Length - 1] = 'x';
				}
			}
				// Strip the 7 "base" suffixes: "e", "s", "n", "t", "em", "er", "nd" from all
				// other terms. Adjectives, Verbs and Adverbs have a total of 52 different
				// possible suffixes, stripping only the characters from they are build
				// does mostly the same
			else 
			{
				// Strip base suffixes as long as enough characters remain.
				bool doMore = true;
				while ( sb.Length > 3 && doMore ) 
				{
					if ( ( sb.Length + substCount > 5 ) && sb.ToString( sb.Length - 2, sb.Length ).Equals( "nd" ) ) 
					{
						sb.Remove( sb.Length - 2, sb.Length );
					}
					else if ( ( sb.Length + substCount > 4 ) && sb.ToString( sb.Length - 2, sb.Length ).Equals( "er" ) ) 
					{
						sb.Remove( sb.Length - 2, sb.Length );
					}
					else if ( ( sb.Length + substCount > 4 ) && sb.ToString( sb.Length - 2, sb.Length ).Equals( "em" ) ) 
					{
						sb.Remove( sb.Length - 2, sb.Length );
					}
					else if ( sb[sb.Length - 1] == 't' ) 
					{
						sb.Remove( sb.Length - 1, 1 );
					}
					else if ( sb[sb.Length - 1] == 'n' ) 
					{
						sb.Remove( sb.Length - 1, 1 );
					}
					else if ( sb[sb.Length - 1] == 's' ) 
					{
						sb.Remove( sb.Length - 1, 1 );
					}
					else if ( sb[sb.Length - 1] == 'e' ) 
					{
						sb.Remove( sb.Length - 1, 1 );
					}
					else 
					{
						doMore = false;
					}
				}
			}
			sb = resubstitute( sb );
			if ( !uppercase ) 
			{
				sb = removeParticleDenotion( sb );
			}
			return sb.ToString();
		}

		///<summary>
		/// Removes a particle denotion ("ge") from a term, but only if at least 3
		/// characters will remain.
		///
		/// @return  The term without particle denotion, if there was one.
		///</summary>
		private StringBuilder removeParticleDenotion( StringBuilder buffer ) 
		{
			for ( int c = 0; c < buffer.Length; c++ ) 
			{
				// Strip from the beginning of the string to the "ge" inclusive
				if ( c < ( buffer.Length - 4 ) && buffer[c] == 'g' && buffer[c + 1] == 'e' ) 
				{
					buffer.Remove( 0, c + 2 );
				}
			}
			return sb;
		}

		///<summary>
		/// Do some substitutions for the term to reduce overstemming:
		///
		/// - Substitute Umlauts with their corresponding vowel: äöü -> aou,
		///   "ß" is substituted by "ss"
		/// - Substitute a second char of an pair of equal characters with
		///   an asterisk: ?? -> ?///
		/// - Substitute some common character combinations with a token:
		///   sch/ch/ei/ie/ig/st -> $/§/%/&amp;/#/!
		///
		/// @return  The term with all needed substitutions.
		///</summary>
		private StringBuilder substitute( StringBuilder buffer ) 
		{
			substCount = 0;
			for ( int c = 0; c < buffer.Length; c++ ) 
			{
				// Replace the second char of a pair of the equal characters with an asterisk
				if ( c > 0 && buffer[c] == buffer[c - 1]  ) 
				{
					buffer[c] = '*';
				}
					// Substitute Umlauts.
				else if ( buffer[c] == 'ä' ) 
				{
					buffer[c] = 'a';
				}
				else if ( buffer[c] == 'ö' ) 
				{
					buffer[c] = 'o';
				}
				else if ( buffer[c] == 'ü' ) 
				{
					buffer[c] = 'u';
				}
				// Take care that at least one character is left left side from the current one
				if ( c < buffer.Length - 1 ) 
				{
					if ( buffer[c] == 'ß' ) 
					{
						buffer[c] = 's';
						buffer.Insert( c + 1, 's' );
						substCount++;
					}
						// Masking several common character combinations with an token
					else if ( ( c < buffer.Length - 2 ) && buffer[c] == 's' && buffer[c + 1] == 'c' && buffer[c + 2] == 'h' ) 
					{
						buffer[c] = '$';
						buffer.Remove( c + 1, c + 3 );
						substCount =+ 2;
					}
					else if ( buffer[c] == 'c' && buffer[c + 1] == 'h' ) 
					{
						buffer[c] = '§';
						buffer.Remove( c + 1, 1 );
						substCount++;
					}
					else if ( buffer[c] == 'e' && buffer[c + 1] == 'i' ) 
					{
						buffer[c] = '%';
						buffer.Remove( c + 1, 1 );
						substCount++;
					}
					else if ( buffer[c] == 'i' && buffer[c + 1] == 'e' ) 
					{
						buffer[c] = '&';
						buffer.Remove( c + 1, 1 );
						substCount++;
					}
					else if ( buffer[c] == 'i' && buffer[c + 1] == 'g' ) 
					{
						buffer[c] = '#';
						buffer.Remove( c + 1, 1 );
						substCount++;
					}
					else if ( buffer[c] == 's' && buffer[c + 1] == 't' ) 
					{
						buffer[c] = '!';
						buffer.Remove( c + 1, 1 );
						substCount++;
					}
				}
			}
			return buffer;
		}

		///<summary>
		/// Checks a term if it can be processed correctly.
		///
		/// @return  true if, and only if, the given term consists in letters.
		///</summary>
		private bool isStemmable( String term ) 
		{
			bool upper = false;
			int first = -1;
			for ( int c = 0; c < term.Length; c++ ) 
			{
				// Discard terms that contain non-letter characters.
				if ( !Char.IsLetter( term[c] ) ) 
				{
					return false;
				}
				// Discard terms that contain multiple uppercase letters.
				if ( Char.IsUpper( term[c] ) ) 
				{
					if ( upper ) 
					{
						return false;
					}
						// First encountered uppercase letter, set flag and save
						// position.
					else 
					{
						first = c;
						upper = true;
					}
				}
			}
			// Discard the term if it contains a single uppercase letter that
			// is not starting the term.
			if ( first > 0 ) 
			{
				return false;
			}
			return true;
		}

		///<summary>
		/// Undoes the changes made by substitute(). That are character pairs and
		/// character combinations. Umlauts will remain as their corresponding vowel,
		/// as "ß" remains as "ss".
		///
		/// @return  The term without the not human readable substitutions.
		///</summary>
		private StringBuilder resubstitute( StringBuilder buffer ) 
		{
			for ( int c = 0; c < buffer.Length; c++ ) 
			{
				if ( buffer[c] == '*' ) 
				{
					char x = buffer[c - 1];
					buffer[c] = x;
				}
				else if ( buffer[c] == '$' ) 
				{
					buffer[c] = 's';
					buffer.Insert( c + 1, new char[]{'c', 'h'}, 0, 2 );
				}
				else if ( buffer[c] == '§' ) 
				{
					buffer[c] = 'c';
					buffer.Insert( c + 1, 'h' );
				}
				else if ( buffer[c] == '%' ) 
				{
					buffer[c] = 'e';
					buffer.Insert( c + 1, 'i' );
				}
				else if ( buffer[c] == '&' ) 
				{
					buffer[c] = 'i';
					buffer.Insert( c + 1, 'e' );
				}
				else if ( buffer[c] == '#' ) 
				{
					buffer[c] = 'i';
					buffer.Insert( c + 1, 'g' );
				}
				else if ( buffer[c] == '!' ) 
				{
					buffer[c] = 's';
					buffer.Insert( c + 1, 't' );
				}
			}
			return buffer;
		}
	}
}
