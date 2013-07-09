import std.stdio,
		std.container;

/**
 Defining a Linkedlist. A list with a forward pointer to the next item. This is done by creating
 a "Node" struct with a value and a _next pointer to another node. 

 The interesting bit is how D allows you to create the node. Using the "new" operator, the D compiler
 allocates space for a new "Node" struct on the garbage collected heap. 

 At any point you only need to maintain a pointer to the first item (with no references whatever to any
 of the other nodes)
*/

template Lists(T)
{
	class Stack
	{
		protected :
		
			struct Node
			{
			    T _payload;
			    Node* _next;
			    this(T a, Node* b) { _payload = a; _next = b; }
			}
		
			Node* _root;
		    size_t length;
	    
	    public:
	    this() {}
	    
	    this(T value)
	    {
	    	push(value);
	    }
	    
	    this(T[] values)
	    {
	    	foreach(v; values)
	    		push(v);
	    }
	    
	    /**
	     O(1) insertion in all cases.
	    */
	    size_t push(T)(T value)
	    {
	        auto newRoot = new Node(value, _root);
	        _root = newRoot;
	        return ++length;
	    }
	    
	    /**
	     O(1) operation, always
	    */
	    T pop()
	    {
	    	if(!_root)
	    		return null;
	    		
			auto val = _root._payload;
			_root = _root._next;
			--length;
			
			return val;
	    }
	    
	    /**
	     O(n)
	    */
	    void print()
	    {
	    	auto next = _root;
			while(next)
			{
				writeln(next._payload);
				next = next._next;
			}
			
			writeln("-----------");
	    }
	}
	
	class List : Stack
	{
		this(){};
		
		this(T value)
	    {
	    	super(value);
	    }
	    
	    this(T[] values)
	    {
	    	super(values);
	    }
	    
		/**
	     O(n) insertion at worst case.
	    */
	    bool insertAfter(T value, T after)
	    {
	    	auto next = _root;
			while(next)
			{
				if(next._payload == after)
				{
					auto t = next._next;
					auto n = new Node(value, next);
					next._next = n;
					n._next = t;
					
					return true;
				}
				
				next = next._next;
			}
			
			return false;
	    }
	}
	
	class DoublyLinkedList
	{
		
	}
	
}

void main()
{
	auto list = new Lists!(string).List(["Adil", "Baig", "Abdul", "Aziz"]);
	
	list.print(); 
	list.push("Batman");
	list.print();
	
//	auto list = cast(Lists!(string).List)stack; //Doesn't work. Why?
	list.insertAfter("SpiderMan", "Batman");
	list.print();
	
	writeln("Pop : ", list.pop());
	list.print();

}