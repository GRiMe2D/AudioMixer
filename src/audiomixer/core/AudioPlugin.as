package audiomixer.core
{
	import flash.utils.getQualifiedClassName;
	
	import errors.AbstractClassError;
	import errors.AbstractMethodError;

	public class AudioPlugin implements IAudioInput
	{
		
		public function AudioPlugin()
		{
			if (getQualifiedClassName(this) == "audiomixer.core::Plugin") {
				throw new AbstractClassError();
			}
		}
		
		public function input(packet:AudioPacket):void {
			throw new AbstractMethodError();
		}
		
		public function get name():String {
			throw new AbstractMethodError();
		}
	}
}