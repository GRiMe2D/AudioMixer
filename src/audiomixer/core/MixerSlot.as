package audiomixer.core
{
	
	public class MixerSlot implements IAudioInput
	{
		
		protected var m_nextslot:IAudioInput;
		
		
		public function MixerSlot()
		{
			
		}
		
		public function set nextslot(to:IAudioInput):void {
			m_nextslot = nextslot;
		}
		
		public function get nextslot():IAudioInput {
			return m_nextslot;
		}
		
		public function input(signal:AudioSignal):void
		{
			workOn(signal);
			out(signal);
		}
		
		protected function workOn(signal:AudioSignal):void {
			
		}
		
		protected function out(signal:AudioSignal):void {
			if (m_nextslot) {
				m_nextslot.input(signal);
			}
		}
	}
}