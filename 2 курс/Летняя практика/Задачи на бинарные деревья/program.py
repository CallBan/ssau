import graphviz


class Node:
    def __init__(self, data):
        self.left = None
        self.right = None
        self.data = data


class BalancedTree:
    def __init__(self, n, numbers):
        self.root = Node(numbers.pop(0))
        self.root.left = create_balanced_node(self.root.left, n // 2, numbers)
        self.root.right = create_balanced_node(self.root.right, n - 1 - n // 2, numbers)


def create_balanced_node(node, n, numbers):
    if n == 0:
        return None
    else:
        node = Node(numbers.pop(0))
        node.left = create_balanced_node(node.left, n // 2, numbers)
        node.right = create_balanced_node(node.right, n - 1 - n // 2, numbers)
    return node


def convert_tree(node: Node):
    if node.left and node.right:
        if node.data % 2 == 1:
            delete_nodes(node.left)
            node.left = None
            convert_tree(node.right)
        else:
            delete_nodes(node.right)
            node.right = None
            convert_tree(node.left)
    elif node.left:
        convert_tree(node.left)
    elif node.right:
        convert_tree(node.right)


def delete_nodes(node: Node):
    if node.left:
        delete_nodes(node.left)
    if node.right:
        delete_nodes(node.right)
    node.left = None
    node.right = None


def show_tree(my_nood, my_dot):
    if my_nood.left:
        new_node = str(my_nood.left.data)
        old_node = str(my_nood.data)
        my_dot.node(new_node, new_node)
        my_dot.edge(old_node, new_node, style="dashed")

        show_tree(my_nood.left, my_dot)

    if my_nood.right:
        new_node = str(my_nood.right.data)
        old_node = str(my_nood.data)
        my_dot.node(new_node, new_node)
        my_dot.edge(old_node, new_node)
        show_tree(my_nood.right, my_dot)


count = int(input('Введите количество чисел: '))
s = input('Введите числа через пробел: ')
new_numbers = [int(x) for x in s.split()]


new_tree = BalancedTree(count, new_numbers)
dot = graphviz.Digraph()
show_tree(new_tree.root, dot)
dot.format = 'png'
dot.render('Graph', view=True)

convert_tree(new_tree.root)
new_dot = graphviz.Digraph()
show_tree(new_tree.root, new_dot)
new_dot.format = 'png'
new_dot.render('Graph1', view=True)

print('Готово!')

# index = 9999
#
#
# def show_tree(my_nood):
#     global index
#     if my_nood.left:
#         new_node = str(my_nood.left.data)
#         old_node = str(my_nood.data)
#         dot.node(new_node, new_node)
#         dot.edge(old_node, new_node)
#
#         show_tree(my_nood.left)
#     else:
#         new_node = str(index)
#         old_node = str(my_nood.data)
#         dot.node(new_node, '', color='white')
#         dot.edge(old_node, '', color='white')
#         index += 1
#
#     if my_nood.right:
#         new_node = str(my_nood.right.data)
#         old_node = str(my_nood.data)
#         dot.node(new_node, new_node)
#         dot.edge(old_node, new_node)
#         show_tree(my_nood.right)
#     else:
#         new_node = str(index)
#         old_node = str(my_nood.data)
#         dot.node(new_node, '', color='white')
#         dot.edge(old_node, '', color='white')
#         index += 1
