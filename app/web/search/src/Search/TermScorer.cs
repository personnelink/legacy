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
	internal sealed class TermScorer : Scorer 
	{
		private ITermDocs termDocs;
		private byte[] norms;
		private float weight;
		private int doc;

		private int[] docs = new int[128];	  // buffered doc numbers
		private int[] freqs = new int[128];	  // buffered term freqs
		private int pointer;
		private int pointerMax;

		private const int SCORE_CACHE_SIZE = 32;
		private float[] scoreCache = new float[SCORE_CACHE_SIZE];

		internal TermScorer(ITermDocs td, byte[] n, float w) 
		{
			termDocs = td;
			norms = n;
			weight = w;

			for (int i = 0; i < SCORE_CACHE_SIZE; i++)
				scoreCache[i] = Similarity.Tf(i) * weight;

			pointerMax = termDocs.Read(docs, freqs);	  // fill buffers

			if (pointerMax != 0)
				doc = docs[0];
			else 
			{
				termDocs.Close();				  // close stream
				doc = Int32.MaxValue;			  // set to sentinel value
			}
		}

		public override void Score(HitCollector c, int end) 
		{
			int d = doc;				  // cache doc in local
			while (d < end) 
			{				  // for docs in window
				int f = freqs[pointer];
				float score =				  // compute tf(f)*weight
					f < SCORE_CACHE_SIZE			  // check cache
					? scoreCache[f]			  // cache hit
					: Similarity.Tf(f)*weight;		  // cache miss

				score *= Similarity.Norm(norms[d]);	  // normalize for field

				c.Collect(d, score);			  // collect score

				if (++pointer == pointerMax) 
				{
					pointerMax = termDocs.Read(docs, freqs);  // refill buffers
					if (pointerMax != 0) 
					{
						pointer = 0;
					} 
					else 
					{
						termDocs.Close();			  // close stream
						doc = Int32.MaxValue;		  // set to sentinel value
						return;
					}
				} 
				d = docs[pointer];
			}
			doc = d;					  // flush cache
		}
	}
}
