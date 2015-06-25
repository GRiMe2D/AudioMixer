package audiomixer.core
{
	import audiomixer.utils.amp2db;
	import audiomixer.utils.db2amp;

	public class SignalVolume
	{
		
		private var m_db:Number;
		private var m_amp:Number;
		
		
		public function SignalVolume(db:Number = Number.NaN, amp:Number = Number.NaN)
		{
			
			if (!isNaN(db)) {
				this.db = db;
			} else if (!isNaN(amp)) {
				this.amp = amp;
			} else {
				this.db = 0;
			}
		}
		
		public function set db(to:Number):void {
			m_db = to;
			m_amp = db2amp(m_db);
		}
		
		public function get db():Number {
			return m_db;
		}
		
		public function set amp(to:Number):void {
			m_amp = to;
			m_db = amp2db(m_amp);
		}
		
		public function get amp():Number {
			return m_amp;
		}
	}
}