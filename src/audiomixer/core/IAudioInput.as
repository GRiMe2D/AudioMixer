package audiomixer.core
{
	public interface IAudioInput
	{
		function input(packet:AudioPacket):void;
	}
}