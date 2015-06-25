package errors
{
	public class AbstractClassError extends Error
	{
		public function AbstractClassError()
		{
			super("Using abstract class", 0);
		}
	}
}