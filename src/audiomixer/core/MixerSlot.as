package audiomixer.core
{
	import generators.WhiteNoise;
	
	public class MixerSlot implements IAudioInput
	{
		
		protected var m_nextslot:IAudioInput;
		protected var m_effects:Vector.<IAudioInput>;
		
		
		public function MixerSlot()
		{
			m_effects = new Vector.<IAudioInput>;
			m_effects.push(new WhiteNoise());
		}
		
		public function set nextslot(to:IAudioInput):void {
			m_nextslot = to;
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
			var effect:IAudioInput;
			for each (effect in m_effects) {
				effect.input(packet);
			}
		}
		
		protected function out(packet:AudioPacket):void {
			if (m_nextslot) {
				m_nextslot.input(packet);
			}
		}
	}
}