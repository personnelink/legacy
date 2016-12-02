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
	///Abstract class for enumerating a subset of all terms.
	///
	///<p>Term enumerations are always ordered by Term.CompareTo(). Each term in
	///the enumeration is greater than all that precede it.</p>
	///</summary>
	public abstract class FilteredTermEnum : ITermEnum 
	{
		private Term currentTerm = null;
		private ITermEnum actualEnum = null;
    
		/// <summary>
		/// Initializes a new instance of the FilteredTermEnum class.
		/// </summary>
		public FilteredTermEnum(IndexReader reader, Term term) {}

		///<summary> Equality compare on the term </summary>
		public abstract bool TermCompare(Term term);
    
		///<summary> Equality measure on the term </summary>
		public abstract float Difference();

		///<summary> Indiciates the end of the enumeration has been reached </summary>
		public abstract bool EndEnum();
    
		/// <summary>
		/// [To be supplied.]
		/// </summary>
		public void SetEnum(ITermEnum actualEnum)
		{
			this.actualEnum = actualEnum;
			// Find the first term that matches
			Term term = actualEnum.Term();
			if (TermCompare(term)) 
				currentTerm = term;
			else Next();
		}
    
		///<summary> 
		/// Returns the docFreq of the current Term in the enumeration.
		/// Initially invalid, valid after Next() called for the first time. 
		///</summary>
		public int DocFreq() 
		{
			if (actualEnum == null) return -1;
			return actualEnum.DocFreq();
		}
    
		///<summary> Increments the enumeration to the next element.  True if one exists. </summary>
		public bool Next() 
		{
			if (actualEnum == null) return false; // the actual enumerator is not initialized!
			currentTerm = null;
			while (currentTerm == null) 
			{
				if (EndEnum()) return false;
				if (actualEnum.Next()) 
				{
					Term term = actualEnum.Term();
					if (TermCompare(term)) 
					{
						currentTerm = term;
						return true;
					}
				}
				else return false;
			}
			currentTerm = null;
			return false;
		}
    
		///<summary>
		/// Returns the current Term in the enumeration.
		/// Initially invalid, valid after Next() called for the first time.
		/// </summary>
		public Term Term() 
		{
			return currentTerm;
		}
    
		///<summary>
		/// Closes the enumeration to further activity, freeing resources.
		///</summary>
		public virtual void Close() 
		{
			actualEnum.Close();
			currentTerm = null;
			actualEnum = null;
		}
	}
}
