package data  {

	/**
	 * @author Ron Valstar
	 */
	public class FastPrng {
		
		public static var seed:uint = 123;
		private static const MERSENNE:uint = 2147483647;
		
		public static function rnd(_seed:uint=0):uint {
			seed = (_seed===0?seed:_seed)*16807%MERSENNE;
			return seed;
		}
		
		public static function random(_seed:uint=0):Number {
			return FastPrng.rnd(_seed)/MERSENNE;
		}
	}
}
