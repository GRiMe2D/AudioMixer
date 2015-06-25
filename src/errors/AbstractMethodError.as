package errors
{
	public class AbstractMethodError extends Error
	{
		public function AbstractMethodError() {
			super("Using abstract method", 1);
		}
	}
}