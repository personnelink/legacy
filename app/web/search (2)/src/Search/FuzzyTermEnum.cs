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
	/// Subclass of FilteredTermEnum for enumerating all terms that are similiar to the specified filter term.
	///<p>Term enumerations are always ordered by Term.CompareTo().
	///Each term in the enumeration is greater than all that precede it.</p>
	///</summary>
	public class FuzzyTermEnum : FilteredTermEnum 
	{
		double distance;
		//bool fieldMatch = false;
		bool endEnum = false;

		Term searchTerm = null;
		string field = "";
		string text = "";
		int textlen;
    
		/// <summary>
		/// Initializes a new instance of the FuzzyTermEnum class.
		/// </summary>
		public FuzzyTermEnum(IndexReader reader, Term term) : base(reader, term) 
		{
			//super(reader, term);
			searchTerm = term;
			field = searchTerm.Field;
			text = searchTerm.Text;
			textlen = text.Length;
			SetEnum(reader.Terms(new Term(searchTerm.Field, "")));
		}
    
		///<summary>
		///The termCompare method in FuzzyTermEnum uses Levenshtein distance to 
		///calculate the distance between the given term and the comparing term. 
		///</summary>
		public override bool TermCompare(Term term) 
		{
			if (field == term.Field) 
			{
				string target = term.Text;
				int targetlen = target.Length;
				int dist = EditDistance(text, target, textlen, targetlen);
				distance = 1 - ((double)dist / (double)Math.Min(textlen, targetlen));
				return (distance > FUZZY_THRESHOLD);
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
			return (float)((distance - FUZZY_THRESHOLD) * SCALE_FACTOR);
		}

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		/// <returns>[To be supplied.]</returns>
		public override bool EndEnum() 
		{
			return endEnum;
		}
    
		//*****************************
		// Compute Levenshtein distance
		//*****************************

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		public const double FUZZY_THRESHOLD = 0.5;

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		public const double SCALE_FACTOR = 1.0f / (1.0f - FUZZY_THRESHOLD);
    
		///<summary>
		///Finds and returns the smallest of three integers 
		///</summary>
		private static int Min(int a, int b, int c) 
		{
			int t = (a < b) ? a : b;
			return (t < c) ? t : c;
		}
    
		///<summary>
		/// This static array saves us from the time required to create a new array
		/// everytime editDistance is called.
		///</summary>
		private int[][] e = new int[0][];//{new int[0]};
    
		///<summary>
		///Levenshtein distance also known as edit distance is a measure of similiarity
		///between two strings where the distance is measured as the number of character 
		///deletions, insertions or substitutions required to transform one string to 
		///the other string. 
		///<p>This method takes in four parameters; two strings and their respective 
		///lengths to compute the Levenshtein distance between the two strings.
		///The result is returned as an integer.</p>
		///</summary> 
		private int EditDistance(string s, string t, int n, int m) 
		{
			if (e.Length <= n || e[0].Length <= m) 
			{
				int x = Math.Max(e.Length, n+1);
				int y = Math.Max(e.Length, m+1);
				e = new int[x][];
				for(int z=0; z<x;z++)
					e[z] = new int[y];
				//{ new int[y] };
			}
			int[][] d = e; // matrix
			int i; // iterates through s
			int j; // iterates through t
			char s_i; // ith character of s
        
			if (n == 0) return m;
			if (m == 0) return n;
        
			// init matrix d
			for (i = 0; i <= n; i++) d[i][0] = i;
			for (j = 0; j <= m; j++) d[0][j] = j;
        
			// start computing edit distance
			for (i = 1; i <= n; i++) 
			{
				s_i = s[i - 1];
				for (j = 1; j <= m; j++) 
				{
					if (s_i != t[j-1])
						d[i][j] = Min(d[i-1][j], d[i][j-1], d[i-1][j-1])+1;
					else d[i][j] = Min(d[i-1][j]+1, d[i][j-1]+1, d[i-1][j-1]);
				}
			}
        
			// we got the result!
			return d[n][m];
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
