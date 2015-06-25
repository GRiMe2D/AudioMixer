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
		
		public function input(packet:AudioPacket):void
		{
			workOn(packet);
			out(packet);
		}
		
		protected function workOn(packet:AudioPacket):void {
			
		}
		
		protected function out(packet:AudioPacket):void {
			if (m_nextslot) {
				m_nextslot.input(packet);
			}
		}
	}
}