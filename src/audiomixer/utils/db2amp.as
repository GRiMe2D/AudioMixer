package audiomixer.utils
{
	public function db2amp(db:Number):Number {
		if (isFinite(db)) {
			return Math.pow(10, db / 20);
		} else {
			return 0;
		}
	}
}