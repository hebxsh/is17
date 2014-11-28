/**
 * Simplex Noise in 2D, 3D and 4D. Based on the example code of this paper:
 * http://staffwww.itn.liu.se/~stegu/simplexnoise/simplexnoise.pdf
 * 
 * @author Stefan Gustavson, Linkping University, Sweden (stegu at itn dot liu
 *         dot se)
 * 
 *         Slight optimizations & restructuring by
 * @author Karsten Schmidt (info at toxi dot co dot uk)
 * 
 *         as3 port by
 * @author Ron Valstar
 * 
 */

package data  {

	public class Simplex {

		private static const F2:Number = 0.5*(Math.sqrt(3) - 1);
		private static const G2:Number = (3 - Math.sqrt(3))/6;
		private static const G22:Number = 2*G2 - 1;
		private static const F3:Number = 1/3;
		private static const G3:Number = 1/6;
		private static const F4:Number = (Math.sqrt(5) - 1)/4;
		private static const G4:Number = (5.0 - Math.sqrt(5))/20;
		private static const G42:Number = G4*2;
		private static const G43:Number = G4*3;
		private static const G44:Number = G4*4 - 1;
		// Gradient vectors for 3D (pointing to mid points of all edges of a unit cube)
		private static const grad3:Array = [[1,1,0],[-1,1,0],[1,-1,0],[-1,-1,0],[1,0,1],[-1,0,1],[1,0,-1],[-1,0,-1],[0,1,1],[0,-1,1],[0,1,-1],[0,-1,-1]];
		// Gradient vectors for 4D (pointing to mid points of all edges of a unit 4D hypercube)
		private static const grad4:Array = [[0,1,1,1],[0,1,1,-1],[0,1,-1,1],[0,1,-1,-1],[0,-1,1,1],[0,-1,1,-1],[0,-1,-1,1],[0,-1,-1,-1],[1,0,1,1],[1,0,1,-1],[1,0,-1,1],[1,0,-1,-1],[-1,0,1,1],[-1,0,1,-1],[-1,0,-1,1],[-1,0,-1,-1],[1,1,0,1],[1,1,0,-1],[1,-1,0,1],[1,-1,0,-1],[-1,1,0,1],[-1,1,0,-1],[-1,-1,0,1],[-1,-1,0,-1],[1,1,1,0],[1,1,-1,0],[1,-1,1,0],[1,-1,-1,0],[-1,1,1,0],[-1,1,-1,0],[-1,-1,1,0],[-1,-1,-1,0]];
		// To remove the need for index wrapping, double the permutation table  length
		private static var perm:Array = [];
		// A lookup table to traverse the simplex around a given point in 4D.
		// Details can be found where this table is used, in the 4D noise method.
		private static var simplex:Array = [[0,1,2,3],[0,1,3,2],[0,0,0,0],[0,2,3,1],[0,0,0,0],[0,0,0,0],[0,0,0,0],[1,2,3,0],[0,2,1,3],[0,0,0,0],[0,3,1,2],[0,3,2,1],[0,0,0,0],[0,0,0,0],[0,0,0,0],[1,3,2,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[1,2,0,3],[0,0,0,0],[1,3,0,2],[0,0,0,0],[0,0,0,0],[0,0,0,0],[2,3,0,1],[2,3,1,0],[1,0,2,3],[1,0,3,2],[0,0,0,0],[0,0,0,0],[0,0,0,0],[2,0,3,1],[0,0,0,0],[2,1,3,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[2,0,1,3],[0,0,0,0],[0,0,0,0],[0,0,0,0],[3,0,1,2],[3,0,2,1],[0,0,0,0],[3,1,2,0],[2,1,0,3],[0,0,0,0],[0,0,0,0],[0,0,0,0],[3,1,0,2],[0,0,0,0],[3,2,0,1],[3,2,1,0]];
		//
		private static var g:Number;
		private static var n0:Number, n1:Number, n2:Number, n3:Number, n4:Number;
		private static var s:Number;
		private static var c:int;
		private static var sc:Array;
		private static var i:int, j:int, k:int, l:int;
		private static var t:Number;
		private static var x0:Number, y0:Number, z0:Number, w0:Number;
		private static var i1:int, j1:int, k1:int, l1:int;
		private static var i2:int, j2:int, k2:int, l2:int;
		private static var i3:int, j3:int, k3:int, l3:int;
		private static var x1:Number, y1:Number, z1:Number, w1:Number;
		private static var x2:Number, y2:Number, z2:Number, w2:Number;
		private static var x3:Number, y3:Number, z3:Number, w3:Number;
		private static var x4:Number, y4:Number, z4:Number, w4:Number;
		private static var ii:int, jj:int, kk:int, ll:int;
		private static var gi0:int, gi1:int, gi2:int, gi3:int, gi4:int;
		private static var t0:Number, t1:Number, t2:Number, t3:Number, t4:Number;
		//
		private static var  oRng:Function = Math.random;
		private static var iOctaves:uint = 1;
		private static var fPersistence:Number = 0.5;
		private static var aOctFreq:Array; // frequency per octave
		private static var aOctPers:Array; // persistence per octave
		private static var fFreq:Number, fPers:Number;
		private static var fPersMax:Number; // 1 / max persistence}
		private static var fResult:Number;
		private static var iSeed:int = 123;
		private static var initialized:Boolean = false;
		//
		// GETTER / SETTER
		//
		// octaves
		/**
		 * The number of octaves used.
		 */
		public static function get octaves():int {
			return iOctaves;
		}

		/**
		 * @private
		 */
		public static function set octaves(_iOctaves:int):void {
			if (iOctaves!=_iOctaves) {
				iOctaves = _iOctaves;
				octFreqPers();
			}
		}

		//
		// falloff
		/**
		 * The amount of falloff.
		 */
		public static function get falloff():Number {
			return fPersistence;
		}

		/**
		 * @private
		 */
		public static function set falloff(_fPersistence:Number):void {
			if (fPersistence!=_fPersistence) {
				fPersistence = _fPersistence;
				octFreqPers();
			}
		}

		//
		// get seed
		/**
		 * The random seed.
		 */
		public static function get seed():Number {
			return iSeed;
		}

		/**
		 * @private
		 */
		public static function set seed(_iSeed:Number):void {
			if (iSeed!=_iSeed) iSeed = _iSeed;
		}

		// prng
		public static function get prng():Function { 
			return oRng; 
		}

		public static function set prng(fn:Function):void {
			oRng = fn;
			calcPermutations();
		}

		//
		// PUBLIC
		/**
		 * Compute the noise value.
		 * @param x Number x value in the noise field.
		 * @param y Number y value in the noise field (default 1).
		 * @param z Number z value in the noise field (default 1).
		 * @param w Number w value in the noise field (default 1).
		 * @example <listing version="3.0" >	Simplex.noise(123,234,12);</listing>
		 */
		public static function noise( x:Number, y:Number = 1, z:Number = 1, w:Number = 1 ):Number {
			if ( !initialized ) init();
			fResult = 0;
			for (g = 0;g<iOctaves;g++) {
				fFreq = Number(aOctFreq[g]);
				fPers = Number(aOctPers[g]);
				if (z===1&&w===1)	fResult += fPers*noise2D(fFreq*x, fFreq*y);
				else if (w===1)		fResult += fPers*noise3D(fFreq*x, fFreq*y, fFreq*z);
				else				fResult += fPers*noise4D(fFreq*x, fFreq*y, fFreq*z, fFreq*w);
			}
			return ( fResult*fPersMax + 1 )*0.5;
		}

		//
		// PRIVATE
		private static function init():void {
			calcPermutations();
			octFreqPers();
			initialized = true;
		}

		// calcPermutations
		private static function calcPermutations():void {
			var i:uint;
			var p:Array = [];
			for (i = 0;i<256;i++) p[i] = Math.floor(oRng()*256);
			// To remove the need for index wrapping, double the permutation table length 
			perm = []; 
			for (i = 0;i<512;i++) perm[i] = p[i&255];
		};

		// octFreqPers
		private static function octFreqPers():void {
			var fFreq:Number, fPers:Number;
			aOctFreq = [];
			aOctPers = [];
			fPersMax = 0;
			for (var i:int;i<iOctaves;i++) {
				fFreq = Math.pow(2, i);
				fPers = Math.pow(fPersistence, i);
				fPersMax += fPers;
				aOctFreq.push(fFreq);
				aOctPers.push(fPers);
			}
			fPersMax = 1/fPersMax;
		}

		// 2D dotproduct
		private static function dot(g:Array, x:Number, y:Number):Number {
			return int(g[0])*x + int(g[1])*y;
		}

		// 3D dotproduct
		private static function dot3(g:Array, x:Number, y:Number, z:Number):Number {
			return int(g[0])*x + int(g[1])*y + int(g[2])*z;
		}

		// 4D dotproduct
		private static function dot4(g:Array, x:Number, y:Number, z:Number, w:Number):Number {
			return int(g[0])*x + int(g[1])*y + int(g[2])*z + int(g[3])*w;
		}

		// fastfloor
		private static function fastfloor(f:Number):int {
			return f>=0?int(f):int(f) - 1 ;
		}

		////////////////////////////////////////////////////
		
		/**
		 * Computes 2D Simplex Noise.
		 * 
		 * @param x
		 *            coordinate
		 * @param y
		 *            coordinate
		 * @return noise value in range -1 ... +1.
		 */
		private static function noise2D(x:Number,y:Number):Number {
			// Noise contributions from the three corners
			// Skew the input space to determine which simplex cell we're in
			s = (x + y)*F2; // Hairy factor for 2D
			i = fastfloor(x + s);
			j = fastfloor(y + s);
			t = (i + j)*G2;
			x0 = x - (i - t); // The x,y distances from the cell origin
			y0 = y - (j - t);
			// For the 2D case, the simplex shape is an equilateral triangle.
			// Determine which simplex we are in.
			// Offsets for second (middle) corner of simplex in (i,j)
			if (x0>y0) {
				i1 = 1;
				j1 = 0;
			} else { 
				// lower triangle, XY order: (0,0)->(1,0)->(1,1)
				i1 = 0;
				j1 = 1;
			} // upper triangle, YX order: (0,0)->(0,1)->(1,1)
			// A step of (1,0) in (i,j) means a step of (1-c,-c) in (x,y), and
			// a step of (0,1) in (i,j) means a step of (-c,1-c) in (x,y), where
			// c = (3-sqrt(3))/6
			x1 = x0 - i1 + G2; // Offsets for middle corner in (x,y) unskewed
			y1 = y0 - j1 + G2;
			x2 = x0 + G22; // Offsets for last corner in (x,y) unskewed
			y2 = y0 + G22;
			// Work out the hashed gradient indices of the three simplex corners
			ii = i&0xff;
			jj = j&0xff;
			// Calculate the contribution from the three corners
			t0 = 0.5 - x0*x0 - y0*y0;
			if (t0>0) {
				t0 *= t0;
				gi0 = int(perm[ii + int(perm[jj])])%12;
				n0 = t0*t0*dot((grad3[gi0] as Array), x0, y0); // (x,y) of grad3 used for 2D gradient
			}
			t1 = 0.5 - x1*x1 - y1*y1;
			if (t1>0) {
				t1 *= t1;
				gi1 = int(perm[ii + i1 + int(perm[jj + j1])])%12;
				n1 = t1*t1*dot((grad3[gi1] as Array), x1, y1);
			}
			t2 = 0.5 - x2*x2 - y2*y2;
			if (t2>0) {
				t2 *= t2;
				gi2 = int(perm[ii + 1 + int(perm[jj + 1])])%12;
				n2 = t2*t2*dot((grad3[gi2] as Array), x2, y2);
			}
			// Add contributions from each corner to get the final noise value.
			// The result is scaled to return values in the interval [-1,1].
			return 70.0*(n0 + n1 + n2);
		}

		/**
		 * Computes 3D Simplex Noise.
		 * 
		 * @param x
		 *            coordinate
		 * @param y
		 *            coordinate
		 * @param z
		 *            coordinate
		 * @return noise value in range -1 ... +1
		 */
		private static function noise3D(x:Number,y:Number,z:Number):Number {
			// Noise contributions from the four corners
			// Skew the input space to determine which simplex cell we're in
			// final double F3 = 1.0 / 3.0;
			s = (x + y + z)*F3; // Very nice and simple skew factor
			// for 3D
			i = fastfloor(x + s);
			j = fastfloor(y + s);
			k = fastfloor(z + s);
			// final double G3 = 1.0 / 6.0; // Very nice and simple unskew factor, too
			t = (i + j + k)*G3;
			x0 = x - (i - t); // The x,y,z distances from the cell origin
			y0 = y - (j - t);
			z0 = z - (k - t);
			// For the 3D case, the simplex shape is a slightly irregular tetrahedron.
			// Determine which simplex we are in.
			if (x0>=y0) { 
				if (y0>=z0) { 
					// X Y Z order
					i1 = 1;
					j1 = 0;
					k1 = 0;
					i2 = 1;
					j2 = 1;
					k2 = 0;
				} else if (x0>=z0) { 
					// X Z Y order
					i1 = 1;
					j1 = 0;
					k1 = 0;
					i2 = 1;
					j2 = 0;
					k2 = 1;
				} else { 
					// Z X Y order
					i1 = 0;
					j1 = 0;
					k1 = 1;
					i2 = 1;
					j2 = 0;
					k2 = 1;
				} 
			} else { 
				// x0<y0 
				if (y0<z0) { 
					// Z Y X order
					i1 = 0;
					j1 = 0;
					k1 = 1;
					i2 = 0;
					j2 = 1;
					k2 = 1;
				} else if (x0<z0) { 
					// Y Z X order
					i1 = 0;
					j1 = 1;
					k1 = 0;
					i2 = 0;
					j2 = 1;
					k2 = 1;
				} else { 
					// Y X Z order
					i1 = 0;
					j1 = 1;
					k1 = 0;
					i2 = 1;
					j2 = 1;
					k2 = 0;
				}
			} 
			// A step of (1,0,0) in (i,j,k) means a step of (1-c,-c,-c) in (x,y,z),
			// a step of (0,1,0) in (i,j,k) means a step of (-c,1-c,-c) in (x,y,z),
			// and
			// a step of (0,0,1) in (i,j,k) means a step of (-c,-c,1-c) in (x,y,z),
			// where
			// c = 1/6.
			x1 = x0 - i1 + G3; // Offsets for second corner in (x,y,z) coords
			y1 = y0 - j1 + G3;
			z1 = z0 - k1 + G3;

			x2 = x0 - i2 + F3; // Offsets for third corner in (x,y,z)
			y2 = y0 - j2 + F3;
			z2 = z0 - k2 + F3;

			x3 = x0 - 0.5; // Offsets for last corner in (x,y,z)
			y3 = y0 - 0.5;
			z3 = z0 - 0.5;
			// Work out the hashed gradient indices of the four simplex corners
			ii = i&0xff;
			jj = j&0xff;
			kk = k&0xff;

			// Calculate the contribution from the four corners
			t0 = 0.6 - x0*x0 - y0*y0 - z0*z0;
			if (t0<0) {
				n0 = 0; 
			} else { 
				t0 *= t0;
				gi0 = int(perm[ii + int(perm[jj + int(perm[kk])])])%12;
				n0 = t0*t0*dot3((grad3[gi0] as Array), x0, y0, z0);
			}
			t1 = 0.6 - x1*x1 - y1*y1 - z1*z1;
			if (t1<0) {
				n1 = 0; 
			} else { 
				t1 *= t1;
				gi1 = int(perm[ii + i1 + int(perm[jj + j1 + int(perm[kk + k1])])])%12;
				n1 = t1*t1*dot3((grad3[gi1] as Array), x1, y1, z1);
			}
			t2 = 0.6 - x2*x2 - y2*y2 - z2*z2;
			if (t2<0) {
				n2 = 0; 
			} else { 
				t2 *= t2;
				gi2 = int(perm[ii + i2 + int(perm[jj + j2 + int(perm[kk + k2])])])%12;
				n2 = t2*t2*dot3((grad3[gi2] as Array), x2, y2, z2);
			}
			t3 = 0.6 - x3*x3 - y3*y3 - z3*z3;
			if (t3<0) {
				n3 = 0; 
			} else { 
				t3 *= t3;
				gi3 = int(perm[ii + 1 + int(perm[jj + 1 + int(perm[kk + 1])])])%12;
				n3 = t3*t3*dot3((grad3[gi3] as Array), x3, y3, z3);
			}
			// Add contributions from each corner to get the final noise value.
			// The result is scaled to stay just inside [-1,1]
			return 32.0* (n0 + n1 + n2 + n3);
		}

        /**
         * Computes 4D Simplex Noise.
         * 
         * @param x
         *            coordinate
         * @param y
         *            coordinate
         * @param z
         *            coordinate
         * @param w
         *            coordinate
         * @return noise value in range -1 ... +1
         */
		private static function noise4D(x:Number,y:Number,z:Number,w:Number):Number {
			// from the five corners
			// Skew the (x,y,z,w) space to determine which cell of 24 simplices
			s = (x + y + z + w) * F4; // Factor for 4D skewing
			i = fastfloor(x + s);
			j = fastfloor(y + s);
			k = fastfloor(z + s);
			l = fastfloor(w + s);
			t = (i + j + k + l) * G4; // Factor for 4D unskewing
			x0 = x - (i - t); // The x,y,z,w distances from the cell origin
			y0 = y - (j - t);
			z0 = z - (k - t);
			w0 = w - (l - t);
			// For the 4D case, the simplex is a 4D shape I won't even try to describe.
			// To find out which of the 24 possible simplices we're in, we need to determine the magnitude ordering of x0, y0, z0 and w0.
			// The method below is a good way of finding the ordering of x,y,z,w and then find the correct traversal order for the simplex were in.
			// First, six pair-wise comparisons are performed between each possible pair of the four coordinates, and the results are used to add up binary bits for an integer index.
			c = 0;
			if (x0>y0) {
				c = 0x20;
			}
			if (x0>z0) {
				c |= 0x10;
			}
			if (y0>z0) {
				c |= 0x08;
			}
			if (x0>w0) {
				c |= 0x04;
			}
			if (y0>w0) {
				c |= 0x02;
			}
			if (z0>w0) {
				c |= 0x01;
			}
			// simplex[c] is a 4-vector with the numbers 0, 1, 2 and 3 in some
			// order. Many values of c will never occur, since e.g. x>y>z>w makes
			// x<z, y<w and x<w impossible. Only the 24 indices which have non-zero
			// entries make any sense. We use a thresholding to set the coordinates
			// in turn from the largest magnitude. The number 3 in the "simplex"
			// array is at the position of the largest coordinate.
			sc = simplex[c] as Array;
			i1 = sc[0] >= 3 ? 1 : 0;
			j1 = sc[1] >= 3 ? 1 : 0;
			k1 = sc[2] >= 3 ? 1 : 0;
			l1 = sc[3] >= 3 ? 1 : 0;
			// The number 2 in the "simplex" array is at the second largest
			// coordinate.
			i2 = sc[0] >= 2 ? 1 : 0;
			j2 = sc[1] >= 2 ? 1 : 0;
			k2 = sc[2] >= 2 ? 1 : 0;
			l2 = sc[3] >= 2 ? 1 : 0;
			// The number 1 in the "simplex" array is at the second smallest
			// coordinate.
			i3 = sc[0] >= 1 ? 1 : 0;
			j3 = sc[1] >= 1 ? 1 : 0;
			k3 = sc[2] >= 1 ? 1 : 0;
			l3 = sc[3] >= 1 ? 1 : 0;
			// The fifth corner has all coordinate offsets = 1, so no need to look
			// that up.
			x1 = x0 - i1 + G4; // Offsets for second corner in (x,y,z,w)
			y1 = y0 - j1 + G4;
			z1 = z0 - k1 + G4;
			w1 = w0 - l1 + G4;

			x2 = x0 - i2 + G42; // Offsets for third corner in (x,y,z,w)
			y2 = y0 - j2 + G42;
			z2 = z0 - k2 + G42;
			w2 = w0 - l2 + G42;

			x3 = x0 - i3 + G43; // Offsets for fourth corner in (x,y,z,w)
			y3 = y0 - j3 + G43;
			z3 = z0 - k3 + G43;
			w3 = w0 - l3 + G43;

			x4 = x0 + G44; // Offsets for last corner in (x,y,z,w)
			y4 = y0 + G44;
			z4 = z0 + G44;
			w4 = w0 + G44;

			// Work out the hashed gradient indices of the five simplex corners
			ii = i&0xff;
			jj = j&0xff;
			kk = k&0xff;
			ll = l&0xff;

			// Calculate the contribution from the five corners
			t0 = 0.6 - x0*x0 - y0*y0 - z0*z0 - w0*w0;
			if (t0<0) {
				n0 = 0; 
			} else { 
				t0 *= t0;
				gi0 = int(perm[ii + int(perm[jj + int(perm[kk + int(perm[ll])])])])%32;
				n0 = t0*t0*dot4((grad4[gi0] as Array), x0, y0, z0, w0);
			}
			t1 = 0.6 - x1*x1 - y1*y1 - z1*z1 - w1*w1;
			if (t1<0) {
				n1 = 0; 
			} else { 
				t1 *= t1;
				gi1 = int(perm[ii + i1 + int(perm[jj + j1 + int(perm[kk + k1 + int(perm[ll + l1])])])])%32;
				n1 = t1*t1*dot4((grad4[gi1] as Array), x1, y1, z1, w1);
			}
			t2 = 0.6 - x2*x2 - y2*y2 - z2*z2 - w2*w2;
			if (t2<0) {
				n2 = 0; 
			} else { 
				t2 *= t2;
				gi2 = int(perm[ii + i2 + int(perm[jj + j2 + int(perm[kk + k2 + int(perm[ll + l2])])])])%32;
				n2 = t2*t2*dot4((grad4[gi2] as Array), x2, y2, z2, w2);
			}
			t3 = 0.6 - x3*x3 - y3*y3 - z3*z3 - w3*w3;
			if (t3<0) {
				n3 = 0; 
			} else { 
				t3 *= t3;
				gi3 = int(perm[ii + i3 + int(perm[jj + j3 + int(perm[kk + k3 + int(perm[ll + l3])])])])%32;
				n3 = t3*t3*dot4((grad4[gi3] as Array), x3, y3, z3, w3);
			}
			t4 = 0.6 - x4*x4 - y4*y4 - z4*z4 - w4*w4;
			if (t4<0) {
				n4 = 0; 
			} else { 
				t4 *= t4;
				gi4 = int(perm[ii + 1 + int(perm[jj + 1 + int(perm[kk + 1 + int(perm[ll + 1])])])])%32;
				n4 = t4*t4*dot4((grad4[gi4] as Array), x4, y4, z4, w4);
			}
			// Sum up and scale the result to cover the range [-1,1]
			return 27.0*(n0 + n1 + n2 + n3 + n4);
		}
	}
}