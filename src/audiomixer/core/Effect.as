package audiomixer.core
{
	import flash.utils.getQualifiedClassName;
	
	import errors.AbstractClassError;
	import errors.AbstractMethodError;

	public class Effect implements IAudioInput
	{
		public function Effect()
		{
			if (getQualifiedClassName(this) == "audiomixer.core::Effect") {
				throw new AbstractClassError();
			}
		}
		
		public function input(packet:AudioPacket):void {
			throw new AbstractMethodError();
		}
	}
}