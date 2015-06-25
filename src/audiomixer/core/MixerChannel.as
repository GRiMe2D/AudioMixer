package audiomixer.core
{
	import audiomixer.utils.mergeAudioPackets;

	public class MixerChannel implements IAudioInput, IAudioOutput
	{
		
		protected var m_plugins_names:Vector.<String>;
		protected var m_plugins:Vector.<IAudioInput>;
		protected var m_preVolume:SignalVolume;
		protected var m_postVolume:SignalVolume;
		protected var m_audiopackets:Vector.<AudioPacket>;
		protected var m_channels:Vector.<MixerChannel>;
		
		
		public function MixerChannel()
		{
			
			m_channels = new Vector.<MixerChannel>;
			m_audiopackets = new Vector.<AudioPacket>;
			m_plugins = new Vector.<IAudioInput>;
			m_plugins_names = new Vector.<String>;
			
			m_preVolume = new SignalVolume();
			m_postVolume = new SignalVolume();
		}
		
		public function input(packet:AudioPacket):void
		{
			
			m_audiopackets.push(packet);
			
			
		}
		
		public function output():AudioPacket {
			var channel:MixerChannel;
			var packet:AudioPacket;
			
			for each (channel in m_channels) {
				packet = channel.output();
				m_audiopackets.push(packet);
			}
			
			packet = mergeAudioPackets(m_audiopackets);
			m_audiopackets.splice(0, m_audiopackets.length);
			
			workOn(packet);
			
			return packet;
		}
		
		protected function workOn(packet:AudioPacket):void {
			var i:int;
			var signal:AudioSignal;
			var effect:IAudioInput;
			
			
			for (i = 0; i < AudioMixer.SOUND_LOOP_NUMBER; i++) {
				signal = packet.get(i);
				signal.r *= m_preVolume.amp;
				signal.l *= m_preVolume.amp;
			}
			
			
			for each (effect in m_plugins) {
				effect.input(packet);
			}
			
			
			for (i = 0; i < AudioMixer.SOUND_LOOP_NUMBER; i++) {
				signal = packet.get(i);
				signal.l *= m_postVolume.amp;
				signal.r *= m_postVolume.amp;
			}
		}
		
		public function set preVolume(db:SignalVolume):void {
			m_preVolume = db;
		}
		
		public function get preVolume():SignalVolume {
			return m_preVolume;
		}
		
		public function set postVolume(db:SignalVolume):void {
			m_postVolume = db
		}
		
		public function get postVolume():SignalVolume {
			return m_postVolume;
		}
		
		public function addPlugin(plugin:Effect):int {
			m_plugins_names.push(plugin.name);
			return m_plugins.push(plugin as IAudioInput) - 1;
		}
	}
}