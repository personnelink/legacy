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

using NUnit.Framework;

using DotnetPark.NLucene.Analysis;
using DotnetPark.NLucene.Index;
using DotnetPark.NLucene.Store;
using DotnetPark.NLucene.Search;
using DotnetPark.NLucene.Documents;

namespace DotnetPark.NLucene.Tests.Search
{
	/// <summary>
	/// A test case for testing a search with wildcard query.
	/// </summary>
	public class TestWildcard : TestCase
	{
		/// <summary>
		/// Initializes a new instance of the test case.
		/// </summary>
		/// <param name="name">The name of the test case.</param>
		public TestWildcard(string name) : base(name)
		{
			// use base
		}

		/// <summary>
		/// Test for asterisk.
		/// </summary>
		public void TestAsterisk()
		{
			RamDirectory indexStore = new RamDirectory();
			IndexWriter writer = new IndexWriter(indexStore, new SimpleAnalyzer(), true);
			Document doc1 = new Document();
			Document doc2 = new Document();
			doc1.Add(Field.Text("body", "metal"));
			doc2.Add(Field.Text("body", "metals"));
			writer.AddDocument(doc1);
			writer.AddDocument(doc2);
			writer.Optimize();
			IndexSearcher searcher = new IndexSearcher(indexStore);
			Query query1 = new TermQuery(new Term("body", "metal"));
			Query query2 = new WildcardQuery(new Term("body", "metal*"));
			Query query3 = new WildcardQuery(new Term("body", "m*tal"));
			Query query4 = new WildcardQuery(new Term("body", "m*tal*"));

			Hits result;

			result = searcher.Search(query1);
			AssertEquals(1, result.Length);

			result = searcher.Search(query2);
			AssertEquals(2, result.Length);

			result = searcher.Search(query3);
			AssertEquals(1, result.Length);

			result = searcher.Search(query4);
			AssertEquals(2, result.Length);

			writer.Close();
		}

		/// <summary>
		/// Test for questionmark.
		/// </summary>
		public void TestQuestionmark()
		{
			RamDirectory indexStore = new RamDirectory();
			IndexWriter writer = new IndexWriter(indexStore, new SimpleAnalyzer(), true);
			Document doc1 = new Document();
			Document doc2 = new Document();
			Document doc3 = new Document();
			Document doc4 = new Document();
			doc1.Add(Field.Text("body", "metal"));
			doc2.Add(Field.Text("body", "metals"));
			doc3.Add(Field.Text("body", "mXtals"));
			doc4.Add(Field.Text("body", "mXtXls"));
			writer.AddDocument(doc1);
			writer.AddDocument(doc2);
			writer.AddDocument(doc3);
			writer.AddDocument(doc4);
			writer.Optimize();
			IndexSearcher searcher = new IndexSearcher(indexStore);
			Query query1 = new WildcardQuery(new Term("body", "m?tal"));       // 1
			Query query2 = new WildcardQuery(new Term("body", "metal?"));  // 2
			Query query3 = new WildcardQuery(new Term("body", "metals?")); // 1
			Query query4 = new WildcardQuery(new Term("body", "m?t?ls"));  // 3

			Hits result;

			result = searcher.Search(query1);
			AssertEquals(1, result.Length);

			result = searcher.Search(query2);
			AssertEquals(2, result.Length);

			result = searcher.Search(query3);
			AssertEquals(1, result.Length);

			result = searcher.Search(query4);
			AssertEquals(3, result.Length);

			writer.Close();
		}
	}
}
