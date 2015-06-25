package audiomixer.core
{
	public class Effect implements IAudioInput
	{
		public function Effect()
		{
		}
		
		public function input(packet:AudioPacket):void {
			var i:int;
			for (i = 0; i < AudioMixer.SOUND_LOOP_NUMBER; i++) {
				packet.set(i, new AudioSignal(Math.random()));
			}
		}
	}
}