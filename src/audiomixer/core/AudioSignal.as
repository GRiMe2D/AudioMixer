package audiomixer.core
{
	import audiomixer.utils.rad2deg;

	public class AudioSignal
	{
		
		protected var m_r:Number;
		protected var m_l:Number;
		
		public function AudioSignal(r:Number = 0, l:Number = 0)
		{
			m_r = r;
			m_l = l;
		}
		
		public function get r():Number {
			return m_r;
		}
		
		public function set r(to:Number):void {
			m_r = to;
		}
		
		public function get l():Number {
			return m_l;
		}
		
		public function set l(to:Number):void {
			m_l = to;
		}
		
		public function get phase():Number {
			return rad2deg(Math.atan(l/r));
		}
	}
}