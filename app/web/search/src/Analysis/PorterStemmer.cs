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

namespace DotnetPark.NLucene.Analysis
{
	/// <summary>
	/// Represents a Porter's stemmer.
	/// </summary>
	public class PorterStemmer
	{   
		private char[] b;
		private int i,    /* offset into b */
			j, k, k0;
		private bool dirty = false;
		private static int INC = 50; /* unit of size whereby b is increased */
		private static int EXTRA = 1;

		/// <summary>
		/// Initializes a new instance of the PorterStemmer class.
		/// </summary>
		public PorterStemmer() 
		{  
			b = new char[INC];
			i = 0;
		}

		///<summary> 
		/// reset() resets the stemmer so it can stem another word.  If you invoke
		/// the stemmer by calling add(char) and then stem(), you must call reset()
		/// before starting another word.
		///</summary>
		public void reset() { i = 0; dirty = false; }

		///<summary>
		/// Add a character to the word being stemmed.  When you are finished 
		/// adding characters, you can call stem(void) to process the word. 
		///</summary>
		public void add(char ch) 
		{
			if (b.Length <= i + EXTRA) 
			{
				char[] new_b = new char[b.Length+INC];
				for (int c = 0; c < b.Length; c++) 
					new_b[c] = b[c];
				b = new_b;
			}
			b[i++] = ch;
		}

		///<summary>
		/// After a word has been stemmed, it can be retrieved by toString(), 
		/// or a reference to the internal buffer can be retrieved by getResultBuffer
		/// and getResultLength (which is generally more efficient.)
		///</summary>
		public string toString() { return new string(b,0,i); }

		///<summary>
		/// Returns the length of the word resulting from the stemming process.
		///</summary>
		public int getResultLength() { return i; }

		///<summary>
		/// Returns a reference to a character buffer containing the results of
		/// the stemming process.  You also need to consult getResultLength()
		/// to determine the length of the result.
		///</summary>
		public char[] getResultBuffer() { return b; }

		/// <summary>
		/// cons(i) is true &lt;=&gt; b[i] is a consonant.
		/// </summary>
		/// <param name="i">The input parameter.</param>
		/// <returns>True or False.</returns>
		private bool cons(int i) 
		{
			switch (b[i]) 
			{
				case 'a': case 'e': case 'i': case 'o': case 'u': 
					return false;
				case 'y': 
					return (i==k0) ? true : !cons(i-1);
				default: 
					return true;
			}
		}

		/// <summary>
		/// m() measures the number of consonant sequences between k0 and j. if c is
		///   a consonant sequence and v a vowel sequence, and &lt;..&gt; indicates arbitrary
		///   presence,
		///
		///		&lt;c&gt;&lt;v&gt;       gives 0
		///		&lt;c&gt;vc&lt;v&gt;     gives 1
		///		&lt;c&gt;vcvc&lt;v&gt;   gives 2
		///		&lt;c&gt;vcvcvc&lt;v&gt; gives 3
		///		....
		/// </summary>
		/// <returns></returns>
		private int m() 
		{
			int n = 0;
			int i = k0;
			while(true) 
			{
				if (i > j) 
					return n;
				if (! cons(i)) 
					break; 
				i++;
			}
			i++;
			while(true) 
			{
				while(true) 
				{
					if (i > j) 
						return n;
					if (cons(i)) 
						break;
					i++;
				}
				i++;
				n++;
				while(true) 
				{
					if (i > j) 
						return n;
					if (! cons(i)) 
						break;
					i++;
				}
				i++;
			}
		}

		/// <summary>
		/// vowelinstem() is true &lt;=&gt; k0,...j contains a vowel
		/// </summary>
		/// <returns>[To be supplied.]</returns>
		private bool vowelinstem() 
		{
			int i; 
			for (i = k0; i <= j; i++) 
				if (! cons(i)) 
					return true;
			return false;
		}

		/// <summary>
		/// doublec(j) is true &lt;=&gt; j,(j-1) contain a double consonant.
		/// </summary>
		/// <param name="j"></param>
		/// <returns></returns>
		private bool doublec(int j) 
		{
			if (j < k0+1) 
				return false;
			if (b[j] != b[j-1]) 
				return false;
			return cons(j);
		}

		/* cvc(i) is true <=> i-2,i-1,i has the form consonant - vowel - consonant
		   and also if the second c is not w,x or y. this is used when trying to
		   restore an e at the end of a short word. e.g.

				cav(e), lov(e), hop(e), crim(e), but
				snow, box, tray.

		*/
		private bool cvc(int i) 
		{
			if (i < k0+2 || !cons(i) || cons(i-1) || !cons(i-2)) 
				return false;
			else 
			{
				int ch = b[i];
				if (ch == 'w' || ch == 'x' || ch == 'y') return false;
			}
			return true;
		}

		private bool ends(string s) 
		{
			int l = s.Length;
			int o = k-l+1;
			if (o < k0) 
				return false;
			for (int i = 0; i < l; i++) 
				if (b[o+i] != s[i]) 
					return false;
			j = k-l;
			return true;
		}

		/* setto(s) sets (j+1),...k to the characters in the string s, readjusting
		   k. */

		void setto(string s) 
		{
			int l = s.Length;
			int o = j+1;
			for (int i = 0; i < l; i++) 
				b[o+i] = s[i];
			k = j+l;
			dirty = true;
		}

		/* r(s) is used further down. */

		void r(string s) { if (m() > 0) setto(s); }

		/* step1() gets rid of plurals and -ed or -ing. e.g.

				 caresses  ->  caress
				 ponies    ->  poni
				 ties      ->  ti
				 caress    ->  caress
				 cats      ->  cat

				 feed      ->  feed
				 agreed    ->  agree
				 disabled  ->  disable

				 matting   ->  mat
				 mating    ->  mate
				 meeting   ->  meet
				 milling   ->  mill
				 messing   ->  mess

				 meetings  ->  meet

		*/
  
		private void step1() 
		{
			if (b[k] == 's') 
			{
				if (ends("sses")) k -= 2; 
				else if (ends("ies")) setto("i"); 
				else if (b[k-1] != 's') k--;
			}
			if (ends("eed")) 
			{ 
				if (m() > 0) 
					k--; 
			} 
			else if ((ends("ed") || ends("ing")) && vowelinstem()) 
			{  
				k = j;
				if (ends("at")) setto("ate"); 
				else if (ends("bl")) setto("ble"); 
				else if (ends("iz")) setto("ize"); 
				else if (doublec(k)) 
				{
					int ch = b[k--];
					if (ch == 'l' || ch == 's' || ch == 'z') 
						k++;
				}
				else if (m() == 1 && cvc(k)) 
					setto("e");
			}
		}

		/* step2() turns terminal y to i when there is another vowel in the stem. */
  
		private void step2() 
		{ 
			if (ends("y") && vowelinstem()) 
			{
				b[k] = 'i'; 
				dirty = true;
			}
		}

		/* step3() maps double suffices to single ones. so -ization ( = -ize plus
		   -ation) maps to -ize etc. note that the string before the suffix must give
		   m() > 0. */

		private void step3() 
		{ 
			if (k == k0) return; /* For Bug 1 */
			switch (b[k-1]) 
			{
				case 'a': 
					if (ends("ational")) { r("ate"); break; }
					if (ends("tional")) { r("tion"); break; }
					break;
				case 'c': 
					if (ends("enci")) { r("ence"); break; }
					if (ends("anci")) { r("ance"); break; }
					break;
				case 'e': 
					if (ends("izer")) { r("ize"); break; }
					break;
				case 'l': 
					if (ends("bli")) { r("ble"); break; }
					if (ends("alli")) { r("al"); break; }
					if (ends("entli")) { r("ent"); break; }
					if (ends("eli")) { r("e"); break; }
					if (ends("ousli")) { r("ous"); break; }
					break;
				case 'o': 
					if (ends("ization")) { r("ize"); break; }
					if (ends("ation")) { r("ate"); break; }
					if (ends("ator")) { r("ate"); break; }
					break;
				case 's': 
					if (ends("alism")) { r("al"); break; }
					if (ends("iveness")) { r("ive"); break; }
					if (ends("fulness")) { r("ful"); break; }
					if (ends("ousness")) { r("ous"); break; }
					break;
				case 't': 
					if (ends("aliti")) { r("al"); break; }
					if (ends("iviti")) { r("ive"); break; }
					if (ends("biliti")) { r("ble"); break; }
					break;
				case 'g': 
					if (ends("logi")) { r("log"); break; }
					break;
			} 
		}

		/* step4() deals with -ic-, -full, -ness etc. similar strategy to step3. */

		private void step4() 
		{ 
			switch (b[k]) 
			{
				case 'e': 
					if (ends("icate")) { r("ic"); break; }
					if (ends("ative")) { r(""); break; }
					if (ends("alize")) { r("al"); break; }
					break;
				case 'i': 
					if (ends("iciti")) { r("ic"); break; }
					break;
				case 'l': 
					if (ends("ical")) { r("ic"); break; }
					if (ends("ful")) { r(""); break; }
					break;
				case 's': 
					if (ends("ness")) { r(""); break; }
					break;
			}
		}
  
		/* step5() takes off -ant, -ence etc., in context <c>vcvc<v>. */

		private void step5() 
		{
			if (k == k0) return; /* for Bug 1 */
			switch (b[k-1]) 
			{
				case 'a': 
					if (ends("al")) break; 
					return;
				case 'c': 
					if (ends("ance")) break;
					if (ends("ence")) break; 
					return;
				case 'e': 
					if (ends("er")) break; return;
				case 'i': 
					if (ends("ic")) break; return;
				case 'l': 
					if (ends("able")) break;
					if (ends("ible")) break; return;
				case 'n': 
					if (ends("ant")) break;
					if (ends("ement")) break;
					if (ends("ment")) break;
					/* element etc. not stripped before the m */
					if (ends("ent")) break; 
					return;
				case 'o': 
					if (ends("ion") && j >= 0 && (b[j] == 's' || b[j] == 't')) break;
					/* j >= 0 fixes Bug 2 */
					if (ends("ou")) break; 
					return;
					/* takes care of -ous */
				case 's': 
					if (ends("ism")) break; 
					return;
				case 't': 
					if (ends("ate")) break;
					if (ends("iti")) break; 
					return;
				case 'u': 
					if (ends("ous")) break; 
					return;
				case 'v': 
					if (ends("ive")) break; 
					return;
				case 'z': 
					if (ends("ize")) break; 
					return;
				default: 
					return;
			}
			if (m() > 1) 
				k = j;
		}

		/* step6() removes a final -e if m() > 1. */

		private void step6() 
		{
			j = k;
			if (b[k] == 'e') 
			{
				int a = m();
				if (a > 1 || a == 1 && !cvc(k-1)) 
					k--;
			}
			if (b[k] == 'l' && doublec(k) && m() > 1) 
				k--;
		}


		///<summary> 
		/// Stem a word provided as a string.  Returns the result as a string.
		///</summary>
		public string stem(string s) 
		{
			if (stem(s.ToCharArray(), s.Length))
				return toString();
			else 
				return s;
		}

		///<summary> Stem a word contained in a char[].  Returns true if the stemming process
		/// resulted in a word different from the input.  You can retrieve the 
		/// result with getResultLength()/getResultBuffer() or toString(). 
		///</summary>
		public bool stem(char[] word) 
		{
			return stem(word, word.Length);
		}

		///<summary> Stem a word contained in a portion of a char[] array.  Returns
		/// true if the stemming process resulted in a word different from
		/// the input.  You can retrieve the result with
		/// getResultLength()/getResultBuffer() or toString().  
		///</summary>
		public bool stem(char[] wordBuffer, int offset, int wordLen) 
		{
			reset();
			if (b.Length < wordLen) 
			{
				char[] new_b = new char[wordLen + EXTRA];
				b = new_b;
			}
			for (int j=0; j<wordLen; j++) 
				b[j] = wordBuffer[offset+j];
			i = wordLen;
			return stem(0);
		}

		///<summary> Stem a word contained in a leading portion of a char[] array.
		/// Returns true if the stemming process resulted in a word different
		/// from the input.  You can retrieve the result with
		/// getResultLength()/getResultBuffer() or toString().  
		///</summary>
		public bool stem(char[] word, int wordLen) 
		{
			return stem(word, 0, wordLen);
		}

		///<summary> Stem the word placed into the Stemmer buffer through calls to add().
		/// Returns true if the stemming process resulted in a word different
		/// from the input.  You can retrieve the result with
		/// getResultLength()/getResultBuffer() or toString().  
		///</summary>
		public bool stem() 
		{
			return stem(0);
		}

		/// <summary>
		/// [To be supplied.]
		/// </summary>
		/// <param name="i0">[To be supplied.]</param>
		/// <returns>[To be supplied.]</returns>
		public bool stem(int i0) 
		{  
			k = i - 1; 
			k0 = i0;
			if (k > k0+1) 
			{ 
				step1(); step2(); step3(); step4(); step5(); step6(); 
			}
			// Also, a word is considered dirty if we lopped off letters
			// Thanks to Ifigenia Vairelles for pointing this out.
			if (i != k+1)
				dirty = true;
			i = k+1;
			return dirty;
		}

		///<summary> Test program for demonstrating the Stemmer.  It reads a file and
		/// stems each word, writing the result to standard out.  
		/// Usage: Stemmer file-name 
		///</summary>
		public static void Main(string[] args) 
		{
			PorterStemmer s = new PorterStemmer();

			for (int i = 0; i < args.Length; i++) 
			{
				try 
				{
					FileStream fs = new FileStream(args[i], FileMode.Open);
					byte[] buffer = new byte[1024];
					int bufferLen, offset, ch;

					bufferLen = fs.Read(buffer, 0, buffer.Length);
					offset = 0;
					s.reset();

					while(true) 
					{  
						if (offset < bufferLen) 
							ch = buffer[offset++];
						else 
						{
							bufferLen = fs.Read(buffer, 0, buffer.Length);
							offset = 0;
							if (bufferLen < 0) 
								ch = -1;
							else 
								ch = buffer[offset++];
						}

						if (Char.IsLetter((char) ch)) 
						{
							s.add(Char.ToLower((char) ch));
						}
						else 
						{  
							s.stem();
							Console.Write(s.toString());
							s.reset();
							if (ch < 0) 
								break;
							else 
							{
								Console.Write((char) ch);
							}
						}
					}

					fs.Close();
				}
				catch (IOException e) 
				{  
					Console.WriteLine("error reading " + args[i], e);
				}
			}
		}
	}
}
