#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Simple DAG node for expression common subexpression elimination.
typedef struct Node {
    int id;
    char op;
    char *name;   // variable name for leaf
    struct Node *left;
    struct Node *right;
} Node;

Node *mk_node(int id, char op, char *name, Node *l, Node *r) {
    Node *n = malloc(sizeof(Node));
    n->id = id;
    n->op = op;
    n->name = name ? strdup(name) : NULL;
    n->left = l;
    n->right = r;
    return n;
}

void free_node(Node *n) {
    if (!n) return;
    free_node(n->left);
    free_node(n->right);
    free(n->name);
    free(n);
}

char *dump(Node *n) {
    if (!n) return NULL;
    if (n->name) {
        return strdup(n->name);
    }
    char *l = dump(n->left);
    char *r = dump(n->right);
    size_t len = strlen(l)+strlen(r)+8;
    char *out = malloc(len);
    snprintf(out, len, "(%s %c %s)", l, n->op, r);
    free(l);
    free(r);
    return out;
}

int main() {
    printf("Lab 9: DAG-Based Basic-Block Optimization Demo\n");

    // Example basic block (three-address code):
    // t1 = a + b
    // t2 = a + b
    // t3 = t1 * c
    // t4 = t2 * c
    // x = t3 + t4

    Node *a = mk_node(1, 0, "a", NULL, NULL);
    Node *b = mk_node(2, 0, "b", NULL, NULL);
    Node *c = mk_node(3, 0, "c", NULL, NULL);

    Node *t1 = mk_node(4, '+', NULL, a, b);
    Node *t2 = mk_node(5, '+', NULL, a, b); // duplicate expression
    Node *t3 = mk_node(6, '*', NULL, t1, c);
    Node *t4 = mk_node(7, '*', NULL, t2, c); // duplicate expression using t2
    Node *t5 = mk_node(8, '+', NULL, t3, t4);

    printf("Original expression: %s\n", dump(t5));

    // Optimization stage: CSE
    Node *t2_opt = t1; // reuse t1
    Node *t4_opt = t3; // reuse t3
    Node *t5_opt = mk_node(9, '+', NULL, t3, t4_opt);

    printf("After CSE optimization: %s\n", dump(t5_opt));
    printf("Optimized code sample:\n");
    printf("  t1 = a + b\n");
    printf("  t3 = t1 * c\n");
    printf("  x = t3 + t3\n");

    free_node(t5);
    free_node(t5_opt);
    return 0;
}
