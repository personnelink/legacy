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

using NUnit.Framework;

using DotnetPark.NLucene.Analysis;
using DotnetPark.NLucene.Analysis.Standard;
using DotnetPark.NLucene.Search;
using DotnetPark.NLucene.Index;
using QP = DotnetPark.NLucene.QueryParser;

namespace DotnetPark.NLucene.Tests.QueryParser
{
	/// <summary>
	/// A test case for testing main Query Parser features.
	/// </summary>
	public class TestQueryParser : TestCase
	{
		/// <summary>
		/// Initializes a new instance of the TestQueryParser class with the
		/// specified name.
		/// </summary>
		/// <param name="name">The name of the test case.</param>
		public TestQueryParser(string name) : base(name)
		{
			// use base
		}

		/// <summary>
		/// Analizer that used by tests.
		/// </summary>
		public static Analyzer qpAnalyzer = new QPTestAnalyzer();

		/// <summary>
		/// Internal class.
		/// </summary>
		public class QPTestFilter : TokenFilter 
		{

			///<summary>
			/// Filter which discards the token 'stop' and which expands the
			/// token 'phrase' into 'phrase1 phrase2'
			///</summary>
			public QPTestFilter(TokenStream ts) 
			{
				input = ts;
			}
    
			bool inPhrase = false;
			int savedStart=0, savedEnd=0;

			/// <summary>
			/// Internal method.
			/// </summary>
			public override Token Next()
			{
				if (inPhrase) 
				{
					inPhrase = false;
					return new Token("phrase2", savedStart, savedEnd);
				}
				else
					for (Token token = input.Next(); token != null; token = input.Next())
						if (token.TermText == "phrase")
						{
							inPhrase = true;
							savedStart = token.StartOffset;
							savedEnd = token.EndOffset;
							return new Token("phrase1", savedStart, savedEnd);
						}
						else if (token.TermText != "stop")
							return token;
				return null;
			}
		}
  
		/// <summary>
		/// Internal class.
		/// </summary>
		public class QPTestAnalyzer : Analyzer 
		{
			/// <summary>
			/// Internal constructor.
			/// </summary>
			public QPTestAnalyzer() 
			{
			}

			///<summary> Filters LowerCaseTokenizer with StopFilter. </summary>
			public override TokenStream TokenStream(string fieldName, TextReader reader) 
			{
				return new QPTestFilter(new LowerCaseTokenizer(reader));
			}
		}

		/// <summary>
		/// Returns a parsed query instance.
		/// </summary>
		/// <param name="query">A query to be parsed.</param>
		/// <param name="a">An analyzer instance.</param>
		/// <returns>A parsed query.</returns>
		public Query GetQuery(string query, Analyzer a)
		{
			if (a == null)
				a = new SimpleAnalyzer();
			QP.QueryParser qp = new QP.QueryParser("field", a);
			return qp.Parse(query);
		}

		/// <summary>
		/// Checks whether two query are equals.
		/// </summary>
		/// <param name="query">The first query.</param>
		/// <param name="a">An analyzer instance.</param>
		/// <param name="result">The second query.</param>
		public void AssertQueryEquals(string query, Analyzer a, string result)
		{
			Query q = GetQuery(query, a);
			string s = q.ToString("field");
			if (s != result) 
			{
				Fail("Query /" + query + "/ yielded /" + s 
					+ "/, expecting /" + result + "/");
			}
		}

		/// <summary>
		/// Simple tests.
		/// </summary>
		public void TestSimple()
		{
			AssertQueryEquals("term term term", null, "term term term");
			AssertQueryEquals("trm term term", null, "trm term term");
			AssertQueryEquals("mlaut", null, "mlaut");

			AssertQueryEquals("a AND b", null, "+a +b");
			AssertQueryEquals("(a AND b)", null, "+a +b");
			AssertQueryEquals("c OR (a AND b)", null, "c (+a +b)");
			AssertQueryEquals("a AND NOT b", null, "+a -b");
			AssertQueryEquals("a AND -b", null, "+a -b");
			AssertQueryEquals("a AND !b", null, "+a -b");
			AssertQueryEquals("a && b", null, "+a +b");
			AssertQueryEquals("a && ! b", null, "+a -b");

			AssertQueryEquals("a OR b", null, "a b");
			AssertQueryEquals("a || b", null, "a b");
			AssertQueryEquals("a OR !b", null, "a -b");
			AssertQueryEquals("a OR ! b", null, "a -b");
			AssertQueryEquals("a OR -b", null, "a -b");

			AssertQueryEquals("+term -term term", null, "+term -term term");
			AssertQueryEquals("foo:term AND field:anotherTerm", null, 
				"+foo:term +anotherterm");
			AssertQueryEquals("term AND \"phrase phrase\"", null, 
				"+term +\"phrase phrase\"");
			AssertQueryEquals("\"hello there\"", null, "\"hello there\"");
			Assert(GetQuery("a AND b", null) is BooleanQuery);
			Assert(GetQuery("hello", null) is TermQuery);
			Assert(GetQuery("\"hello there\"", null) is PhraseQuery);

			AssertQueryEquals("germ term^2.0", null, "germ term^2");
			AssertQueryEquals("term^2.0", null, "term^2");
			AssertQueryEquals("term^2", null, "term^2");
			AssertQueryEquals("\"germ term\"^2.0", null, "\"germ term\"^2");
			AssertQueryEquals("\"term germ\"^2", null, "\"term germ\"^2");

			AssertQueryEquals("(foo OR bar) AND (baz OR boo)", null, 
				"+(foo bar) +(baz boo)");
			AssertQueryEquals("((a OR b) AND NOT c) OR d", null, 
				"(+(a b) -c) d");
			AssertQueryEquals("+(apple \"steve jobs\") -(foo bar baz)", null, 
				"+(apple \"steve jobs\") -(foo bar baz)");
			AssertQueryEquals("+title:(dog OR cat) -author:\"bob dole\"", null, 
				"+(title:dog title:cat) -author:\"bob dole\"");
		}

		/// <summary>
		/// Tests for punctuation symbols.
		/// </summary>
		public void TestPunct()
		{
			Analyzer a = new WhitespaceAnalyzer();
			AssertQueryEquals("a&b", a, "a&b");
			AssertQueryEquals("a&&b", a, "a&&b");
			AssertQueryEquals(".NET", a, ".NET");
		}

		/// <summary>
		/// Test slop.
		/// </summary>
		public void TestSlop()
		{
			AssertQueryEquals("\"term germ\"~2", null, "\"term germ\"~2");
			AssertQueryEquals("\"term germ\"~2 flork", null, "\"term germ\"~2 flork");
			AssertQueryEquals("\"term\"~2", null, "term");
			AssertQueryEquals("\" \"~2 germ", null, "germ");
			AssertQueryEquals("\"term germ\"~2^2", null, "\"term germ\"~2^2");
		}

		/// <summary>
		/// Test for number occurences.
		/// </summary>
		public void TestNumber()
		{
			// The numbers go away because SimpleAnalzyer ignores them
			AssertQueryEquals("3", null, "");
			AssertQueryEquals("term 1.0 1 2", null, "term");
			AssertQueryEquals("term term1 term2", null, "term term term");

			Analyzer a = new StandardAnalyzer();
			AssertQueryEquals("3", a, "3");
			AssertQueryEquals("term 1.0 1 2", a, "term 1.0 1 2");
			AssertQueryEquals("term term1 term2", a, "term term1 term2");
		}

		/// <summary>
		/// Test for wildcards.
		/// </summary>
		public void TestWildcard()
		{
			AssertQueryEquals("term*", null, "term*");
			AssertQueryEquals("term*^2", null, "term*^2");
			AssertQueryEquals("term~", null, "term~");
			AssertQueryEquals("term~^2", null, "term^2~");
			AssertQueryEquals("term^2~", null, "term^2~");
			AssertQueryEquals("term*germ", null, "term*germ");
			AssertQueryEquals("term*germ^3", null, "term*germ^3");

			Assert(GetQuery("term*", null) is PrefixQuery);
			Assert(GetQuery("term*^2", null) is PrefixQuery);
			Assert(GetQuery("term~", null) is FuzzyQuery);
			Assert(GetQuery("term*germ", null) is WildcardQuery);
		}

		/// <summary>
		/// Test QPA.
		/// </summary>
		public void TestQPA()
		{
			AssertQueryEquals("term term term", qpAnalyzer, "term term term");
			AssertQueryEquals("term +stop term", qpAnalyzer, "term term");
			AssertQueryEquals("term -stop term", qpAnalyzer, "term term");
			AssertQueryEquals("drop AND stop AND roll", qpAnalyzer, "+drop +roll");
			AssertQueryEquals("term phrase term", qpAnalyzer, 
				"term \"phrase1 phrase2\" term");
			AssertQueryEquals("term AND NOT phrase term", qpAnalyzer, 
				"+term -\"phrase1 phrase2\" term");
			AssertQueryEquals("stop", qpAnalyzer, "");
			Assert(GetQuery("term term term", qpAnalyzer) is BooleanQuery);
			Assert(GetQuery("term +stop", qpAnalyzer) is TermQuery);
		}

		/// <summary>
		/// Test for ranges.
		/// </summary>
		public void TestRange()
		{
			AssertQueryEquals("[ a z]", null, "[a-z]");
			Assert(GetQuery("[ a z]", null) is RangeQuery);
			AssertQueryEquals("[ a z ]", null, "[a-z]");
			AssertQueryEquals("{ a z}", null, "{a-z}");
			AssertQueryEquals("{ a z }", null, "{a-z}");
			AssertQueryEquals("{ a z }^2.0", null, "{a-z}^2");
			AssertQueryEquals("[ a z] OR bar", null, "[a-z] bar");
			AssertQueryEquals("[ a z] AND bar", null, "+[a-z] +bar");
			AssertQueryEquals("( bar blar { a z}) ", null, "bar blar {a-z}");
			AssertQueryEquals("gack ( bar blar { a z}) ", null, "gack (bar blar {a-z})");
		}

		/// <summary>
		/// Test for escapes.
		/// </summary>
		public void TestEscaped()
		{
			Analyzer a = new WhitespaceAnalyzer();
			AssertQueryEquals("\\[brackets", a, "\\[brackets");
			AssertQueryEquals("\\[brackets", null, "brackets");
			AssertQueryEquals("\\\\", a, "\\\\");
			AssertQueryEquals("\\+blah", a, "\\+blah");
			AssertQueryEquals("\\(blah", a, "\\(blah");
		}
	}
}
