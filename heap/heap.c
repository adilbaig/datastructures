/*
 * Binary Heap
 *
 * From http://en.wikipedia.org/wiki/Heap_(data_structure):
 * In computer science, a heap is a specialized tree-based data structure that satisfies
 * the heap property: If A is a parent node of B then the key of node A is ordered with respect to the key of node
 * B with the same ordering applying across the heap. Either the keys of parent nodes are always greater than or equal
 * to those of the children and the highest key is in the root node (this kind of heap is called max heap) or the keys
 * of parent nodes are less than or equal to those of the children and the lowest key is in the root node (min heap).
 *
 * This code is an implementation of a Max Binary Heap - http://en.wikipedia.org/wiki/Binary_heap
 *
 *  Created on: 14-Apr-2014
 *  author: adil
 */

#include <stdio.h>

struct Heap {
	int data[100]; //fixed length, for edu purposes.
	int length;
	int currIndex;
};

int get_left_child_index(int index) {
	return 2 * index + 1;
}

int get_right_child_index(int index) {
	return 2 * index + 2;
}

int get_parent_index(int index) {
	if(index == 0)
		return -1;

	return (index - 1)/2;
}

/**
 * In a max heap, the largest value is always at the top of the tree.
 *
 * We start at a leaf node (pre calced) and check if it's parent's value is smaller than ours. If it is we swap.
 * Repeat until root is reached.
 */
void push(struct Heap *heap, int value) {
	int i = heap->currIndex;
	heap->data[i] = value;
	heap->currIndex++;

	while(i > 0) {
		int pi = get_parent_index(i);
		int pv = heap->data[pi];

		if(pv < value) {
			//swap
			heap->data[i] = pv;
			heap->data[pi] = value;
			i = get_parent_index(i);
		}
		else
			return;
	}
}

/**
 * A pop starts at the root node. The highest value is always at the root node.
 *
 * We pop off the root node, then swap the value of the leaf node into the root. We then compare root node with each child .. (see max_heapify)
 *
 */
int pop(struct Heap *heap) {
	int ret = heap->data[0];

	printf("heap->currIndex = %d", heap->currIndex);

	heap->data[0] = heap->data[--heap->currIndex];
	heap->data[heap->currIndex] = 0; //this is equivalent to deleting the pointer

	max_heapify(heap, 0);

	return ret;
}

/**
 *  .. If the parent is greater than both of it's children, we're done. If not, we take the largest of the two children
 *  and swap. We keep doing this until there is nothing to swap
 */
void max_heapify (struct Heap *heap, int i) {

	int left  = get_left_child_index(i);
	int right = get_right_child_index(i);
	int largest = i;

	printf("\n max_heapify : i = %d, largest = %d\n", i, largest);

	if (heap->data[left] > heap->data[largest]) {
		largest = left;
	}

	if(heap->data[right] > heap->data[largest]) {
		largest = left;
	}

	if(largest != i) {
		int t = heap->data[i];
		heap->data[i] = heap->data[largest];
		heap->data[largest] = t;

		max_heapify(heap, largest);
	}
}

void traverse(struct Heap *heap, int index) {
	int i = index;
	if(index > heap->currIndex)
		i = heap->currIndex;

	while(i >= 0) {
		printf("[%d] => %d, ", i, heap->data[i]);
		i = get_parent_index(i);
	}
}

void dump(struct Heap *heap) {
	for(int i = 0; i < heap->length; i++) {
		printf("[%d] => %d, ", i, heap->data[i]);
	}
}

int main()
{
	struct Heap heap = {.length = 100, .currIndex = 0};

	push(&heap, 20);
	push(&heap, 30);
	push(&heap, 10);
	push(&heap, 50);
	push(&heap, 500);

	dump(&heap);
	printf("\n----------------\n");
	traverse(&heap, heap.currIndex);
	printf("\n----------------\n");

//	while(heap.currIndex) {
		pop(&heap);

		dump(&heap);
		printf("\n----------------\n");
		traverse(&heap, heap.currIndex);
		printf("\n----------------\n");
//	}

	return 0;
}
