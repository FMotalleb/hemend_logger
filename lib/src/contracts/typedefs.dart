/// a method that receives object of type [F] and
/// turns it into an object of type [T]
typedef Adapter<F, T> = T Function(F);
