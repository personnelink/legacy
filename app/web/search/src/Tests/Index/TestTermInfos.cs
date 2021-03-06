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

using NUnit.Framework;

using DotnetPark.NLucene.Index;
using DotnetPark.NLucene.Store;

namespace DotnetPark.NLucene.Tests.Index
{
	/// <summary>
	/// A simple test case for testing TermInfos functionality.
	/// </summary>
	public class TestTermInfos : TestCase
	{
		/// <summary>
		/// Initializes a new instance of the test case.
		/// </summary>
		/// <param name="name">The name of the test case.</param>
		public TestTermInfos(string name) : base(name)
		{
			// use base
		}

		/// <summary>
		/// Test for all features.
		/// </summary>
		public void TestAll()
		{
			System.IO.FileInfo file = new System.IO.FileInfo("words.txt");

			Console.WriteLine("Reading word file containing " + file.Length + " bytes");

			DateTime start = DateTime.Now;

			ArrayList keys = new ArrayList();
			System.IO.StreamReader sr = new System.IO.StreamReader(file.FullName);
			for(string key = sr.ReadLine(); key != null; key = sr.ReadLine())
			{
				keys.Add(new Term("word", key));
			}
			sr.Close();

			DateTime end = DateTime.Now;

			Console.WriteLine("{0} milliseconds to read {1} words.",
				((TimeSpan)(end - start)).TotalMilliseconds, keys.Count);

			// ======

			start = DateTime.Now;

			Random gen = new Random(1251971);
			long fp = (gen.Next() & 0xF) + 1;
			long pp = (gen.Next() & 0xF) + 1;
			int[] docFreqs = new int[keys.Count];
			long[] freqPointers = new long[keys.Count];
			long[] proxPointers = new long[keys.Count];
			for (int i = 0; i < keys.Count; i++) 
			{
				docFreqs[i] = (gen.Next() & 0xF) + 1;
				freqPointers[i] = fp;
				proxPointers[i] = pp;
				fp += (gen.Next() & 0xF) + 1;;
				pp += (gen.Next() & 0xF) + 1;;
			}

			end = DateTime.Now;

			Console.WriteLine("{0} milliseconds to generate values.",
				((TimeSpan)(end - start)).TotalMilliseconds);

			// ======

			start = DateTime.Now;
			
			Directory store = FsDirectory.GetDirectory("test.store", true);
			FieldInfos fis = new FieldInfos();

			TermInfosWriter writer = new TermInfosWriter(store, "words", fis);
			fis.Add("word", false);

			for (int i = 0; i < keys.Count; i++)
				writer.Add((Term)keys[i],
					new TermInfo(docFreqs[i], freqPointers[i], proxPointers[i]));

			writer.Close();

			end = DateTime.Now;

			Console.WriteLine("{0} milliseconds to write table",
				((TimeSpan)(end - start)).TotalMilliseconds);

			Console.WriteLine(" table occupies {0} bytes",
				store.FileLength("words.tis"));

			// ======

			start = DateTime.Now;

			TermInfosReader reader = new TermInfosReader(store, "words", fis);

			end = DateTime.Now;

			Console.WriteLine("{0} milliseconds to open table",
				((TimeSpan)(end - start)).TotalMilliseconds);

			// ======

			start = DateTime.Now;

			SegmentTermEnum enm = (SegmentTermEnum)reader.Terms();
			for (int i = 0; i < keys.Count; i++) 
			{
				enm.Next();
				Term key = (Term)keys[i];

				AssertEquals("wrong term: " + enm.Term()
					+ ", expected: " + key
					+ " at " + i,
					key, enm.Term());

				TermInfo ti = enm.TermInfo();
				AssertEquals("wrong value: " + ti.DocFreq.ToString("x")
					+ ", expected: " + docFreqs[i].ToString("x")
					+ " at " + i,
					ti.DocFreq, docFreqs[i]);

				AssertEquals("wrong value: " + ti.FreqPointer.ToString("x")
					+ ", expected: " + freqPointers[i].ToString("x")
					+ " at " + i,
					ti.FreqPointer, freqPointers[i]);

				AssertEquals("wrong value: " + ti.ProxPointer.ToString("x")
					+ ", expected: " + proxPointers[i].ToString("x")
					+ " at " + i,
					ti.ProxPointer, proxPointers[i]);
			}

			end = DateTime.Now;

			Console.WriteLine(" {0} milliseconds to iterate over {1} words",
				((TimeSpan)(end - start)).TotalMilliseconds, keys.Count);

			// ======

			start = DateTime.Now;


			for (int i = 0; i < keys.Count; i++) 
			{
				Term key = (Term)keys[i];
				TermInfo ti = reader.Get(key);


				AssertEquals("wrong value: " + ti.DocFreq.ToString("x")
						+ ", expected: " + docFreqs[i].ToString("x")
						+ " at " + i,
					ti.DocFreq, docFreqs[i]);

				AssertEquals("wrong value: " + ti.FreqPointer.ToString("x")
						+ ", expected: " + freqPointers[i].ToString("x")
						+ " at " + i,
					ti.FreqPointer, freqPointers[i]);

				AssertEquals("wrong value: " + ti.ProxPointer.ToString("x")
						+ ", expected: " + proxPointers[i].ToString("x")
						+ " at " + i,
					ti.ProxPointer, proxPointers[i]);
			}

			end = DateTime.Now;

			Console.WriteLine(" {0} average milliseconds per lookup",
				((TimeSpan)(end - start)).TotalMilliseconds / keys.Count);

			ITermEnum e = reader.Terms(new Term("word", "azz"));
			Console.WriteLine("Word after azz is " + e.Term().Text);

			reader.Close();

			store.Close();

		}
	}
}
