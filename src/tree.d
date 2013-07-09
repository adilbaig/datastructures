import std.stdio;

template Tree(T)
{
	struct Node
	{
		T value;
		Node* lchild;
		Node* rchild;
		
		//this(T v, Node* l, Node* r) { value = v; lchild = l; rchild = r; }
	}
	
	void inorder(Node* node)
	{
		if(node != null)
		{
			debug { writeln("Calling ", node.value); }
			
			inorder(node.lchild);
			writeln(node.value);
			inorder(node.rchild);
		}
	}
	
	void preorder(Node* node)
	{
		if(node != null)
		{
			debug { writeln("Calling ", node.value); }
			
			writeln(node.value);
			preorder(node.lchild);
			preorder(node.rchild);
		}
	}
	
	void postorder(Node* node)
	{
		if(node != null)
		{
			debug { writeln("Calling ", node.value); }
			
			postorder(node.lchild);
			postorder(node.rchild);
			writeln(node.value);
		}
	}
}

void main()
{
	auto e1 = new Tree!(int).Node(1);
	auto e2 = new Tree!(int).Node(2);
	auto e3 = new Tree!(int).Node(3);
	auto e4 = new Tree!(int).Node(4);
	auto e5 = new Tree!(int).Node(5);
	auto e6 = new Tree!(int).Node(6);
	auto e7 = new Tree!(int).Node(7);
	auto e8 = new Tree!(int).Node(8);
	auto e9 = new Tree!(int).Node(9);
	auto e10 = new Tree!(int).Node(10);
	
	e1.lchild = e2;
	e1.rchild = e3;
	
	e2.lchild = e4;
	e2.rchild = e5;
	
	e3.lchild = e6;
	e3.rchild = e7;
	
	e4.lchild = e8;
	e4.rchild = e9;
	
	e5.lchild = e10;
	
	writeln("IN ORDER");
	Tree!(int).inorder(e1);
	
	writeln("PRE ORDER");
	Tree!(int).preorder(e1);
	
	writeln("POST ORDER");
	Tree!(int).postorder(e1);
}