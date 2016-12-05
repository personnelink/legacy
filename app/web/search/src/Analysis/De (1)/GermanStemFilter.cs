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

namespace DotnetPark.NLucene.Analysis.De
{
	///<summary>
	/// A filter that stems German words. It supports a table of words that should
	/// not be stemmed at all. The stemmer used can be changed at runtime after the
	/// filter object is created (as long as it is a GermanStemmer).
	///
	/// @author    Gerhard Schwarz
	/// @version   $Id: GermanStemFilter.java,v 1.3 2002/04/19 19:08:32 otis Exp $
	///</summary> 
	public class GermanStemFilter : TokenFilter 
	{

		///<summary>
		/// The actual token in the input stream.
		///</summary>
		private Token token = null;
		private GermanStemmer stemmer = null;
		private Hashtable exclusions = null;
	
		/// <summary>
		/// Initializes a new instance of the GermanStemFilter class.
		/// </summary>
		public GermanStemFilter( TokenStream ts ) 
		{
			stemmer = new GermanStemmer();
			input = ts;
		}
	
		///<summary>
		/// Builds a GermanStemFilter that uses an exclusiontable.
		///</summary>
		public GermanStemFilter( TokenStream ts, Hashtable exclusiontable ) : this(ts)
		{
			exclusions = exclusiontable;
		}

		///<summary>
		/// @return  Returns the next token in the stream, or null at EOS
		///</summary>
		public override Token Next()
		{
			if ( ( token = input.Next() ) == null ) 
			{
				return null;
			}
				// Check the exclusiontable
			else if ( exclusions != null && exclusions.Contains( token.TermText ) ) 
			{
				return token;
			}
			else 
			{
				String s = stemmer.stem( token.TermText );
				// If not stemmed, dont waste the time creating a new token
				if ( !s.Equals( token.TermText ) ) 
				{
					return new Token( s, token.StartOffset,
						token.EndOffset, token.Type );
				}
				return token;
			}
		}
		///<summary>
		/// Set a alternative/custom GermanStemmer for this filter.
		///</summary>
		public void SetStemmer( GermanStemmer stemmer ) 
		{
			if ( stemmer != null ) 
			{
				this.stemmer = stemmer;
			}
		}
		///<summary>
		/// Set an alternative exclusion list for this filter.
		///</summary>
		public void SetExclusionTable( Hashtable exclusiontable ) 
		{
			exclusions = exclusiontable;
		}
	}
}
