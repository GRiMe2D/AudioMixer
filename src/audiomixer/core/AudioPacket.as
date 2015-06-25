package audiomixer.core
{
	public class AudioPacket
	{
		
		private var packet:Vector.<AudioSignal>;
		private var curPos:int;
		
		public function AudioPacket()
		{
			var i:int;
			
			curPos = 0;
			
			packet = new Vector.<AudioSignal>(AudioMixer.SOUND_LOOP_NUMBER, true);
			for (i = 0; i < AudioMixer.SOUND_LOOP_NUMBER; i++) {
				packet[i] = new AudioSignal();
			}
		}
		
		public function add(audioSignal:AudioSignal):void {
			curPos %= AudioMixer.SOUND_LOOP_NUMBER;
			packet[curPos] = audioSignal;
			curPos++;
		}
		
		public function get(index:int):AudioSignal {
			index %= AudioMixer.SOUND_LOOP_NUMBER;
			return packet[index];
		}
	}
}