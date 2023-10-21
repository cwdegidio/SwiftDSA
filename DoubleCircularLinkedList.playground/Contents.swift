import Foundation

class Node: Equatable {
    var data: Int
    var nextNode: Node?
    var prevNode: Node?
    
    init(data: Int, nextNode: Node? = nil, prevNode: Node? = nil) {
        self.data = data
        self.nextNode = nextNode
        self.prevNode = prevNode
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.data == rhs.data
    }
}

class DoublyCircularLinkedList {
    var firstNode: Node?
    
    init(firstNode: Node? = nil) {
        self.firstNode = firstNode
    }
    
    func insertAtEnd(value: Int) {
        let newNode = Node(data: value)
        
        // If list is empty, we create a single node.
        if firstNode == nil {
            newNode.nextNode = newNode
            newNode.prevNode = newNode
            firstNode = newNode
            return
        }
        
        // If the list has nodes, we need to find the last node
        let lastNode = firstNode?.prevNode
        newNode.nextNode = firstNode
        firstNode?.prevNode = newNode
        newNode.prevNode = lastNode
        lastNode?.nextNode = newNode
    }
    
    func insertAtBeginning(value: Int) {
        if firstNode == nil {
            // If there is no nodes, we just will reuse the logic from
            // insertAtEnd(value:)
            insertAtEnd(value: value)
        }
        
        let newNode = Node(data: value)
        let lastNode = firstNode?.prevNode
        newNode.prevNode = lastNode
        newNode.nextNode = firstNode
        lastNode?.nextNode = newNode
        firstNode?.prevNode = newNode
        firstNode = newNode
    }
    
    func insert(after value1: Int, value value2: Int) {
        let newNode = Node(data: value2)
        
        if let start = firstNode {
            var currentNode = start
            
            while currentNode.data != value1 {
                currentNode = currentNode.nextNode!
            }
            
            let nextNode = currentNode.nextNode
            
            currentNode.nextNode = newNode
            newNode.prevNode = currentNode
            newNode.nextNode = nextNode
            nextNode?.prevNode = newNode
        }
    }
    
    func displayNodes() {
        var currentNode = firstNode
        
        // Show nodes going forward
        print("Going forward:\n")
        
        if let start = firstNode {
            var currentNode = start
            
            while currentNode.nextNode != firstNode {
                print("\(currentNode.data) ")
                currentNode = currentNode.nextNode!
            }
            print("\(currentNode.data) ")
            
            // Show nodes going backward
            currentNode = start.prevNode!
            print("\n\nGoing backward: \n")
            
            while currentNode.prevNode != start.prevNode {
                print("\(currentNode.data) ")
                currentNode = currentNode.prevNode!
            }
            print("\(currentNode.data) ")
            
            // Shows that list is circular
            currentNode = start
            var counter = 0
            
            print("\n\nGoing through the list twice")
            while counter < 2 {
                print("\(currentNode.data) ")
                currentNode = currentNode.nextNode!
                
                if currentNode == firstNode {
                    counter = counter + 1
                }
            }
        }
        
    }
}

// TESTS
var list = DoublyCircularLinkedList()
list.insertAtEnd(value: 100)
list.insertAtBeginning(value: 10)
list.insertAtEnd(value: 99)
list.insertAtEnd(value: 865)
list.insert(after: 100, value: 6)

list.displayNodes()
