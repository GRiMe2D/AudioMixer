package audiomixer.utils
{
	public function amp2db(amp:Number):Number {
		return log10(amp) * 20;
	}
}