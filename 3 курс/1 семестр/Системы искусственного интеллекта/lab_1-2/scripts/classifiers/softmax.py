from builtins import range
import numpy as np
from random import shuffle
from past.builtins import xrange

def softmax_loss_naive(W, X, y, reg):
    """
    Softmax loss function, naive implementation (with loops)

    Inputs have dimension D, there are C classes, and we operate on minibatches
    of N examples.

    Inputs:
    - W: A numpy array of shape (D, C) containing weights.
    - X: A numpy array of shape (N, D) containing a minibatch of data.
    - y: A numpy array of shape (N,) containing training labels; y[i] = c means
      that X[i] has label c, where 0 <= c < C.
    - reg: (float) regularization strength

    Returns a tuple of:
    - loss as single float
    - gradient with respect to weights W; an array of same shape as W
    """
    # Initialize the loss and gradient to zero.
    loss = 0.0
    dW = np.zeros_like(W)

    #############################################################################
    # TODO: Compute the softmax loss and its gradient using explicit loops.     #
    # Store the loss in loss and the gradient in dW. If you are not careful     #
    # here, it is easy to run into numeric instability. Don't forget the        #
    # regularization!                                                           #
    #############################################################################
    # *****START OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****
    loss_sum = 0
    for i in range(X.shape[0]):
        element = X[i]
        label_idx = y[i]
        
        vec = element.dot(W)
              
        softmax = np.exp(vec) / np.exp(vec).sum()
        
        dscores = np.exp(vec) / np.exp(vec).sum()
        
        dscores[label_idx] -= 1 # производная
        dW += element.reshape((X.shape[1], 1)).dot(dscores.reshape(1, W.shape[1])) #X[i] * W[i]
           
        my_reg = (0.5 * W ** 2).sum()
        loss_i = - np.log(softmax[label_idx]) + reg * my_reg
                      
        loss_sum += loss_i
        
      
    loss = loss_sum / X.shape[0]
    dW = dW / X.shape[0]
    # *****END OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

    return loss, dW


def softmax_loss_vectorized(W, X, y, reg):
    """
    Softmax loss function, vectorized version.

    Inputs and outputs are the same as softmax_loss_naive.
    """
    # Initialize the loss and gradient to zero.
    loss = 0.0
    dW = np.zeros_like(W)

    #############################################################################
    # TODO: Compute the softmax loss and its gradient using no explicit loops.  #
    # Store the loss in loss and the gradient in dW. If you are not careful     #
    # here, it is easy to run into numeric instability. Don't forget the        #
    # regularization!                                                           #
    #############################################################################
    # *****START OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****
    scores = X.dot( W)
    num_examples = X.shape[0]
    # get unnormalized probabilities
    t = scores - np.max(scores)
    exp_scores = np.exp(t)
    # normalize them for each example
    probs = exp_scores / np.sum(exp_scores, axis=1, keepdims=True)

    correct_logprobs = -np.log(probs[range(num_examples),y])
    
    dscores = probs
    dscores[range(X.shape[0]),y] -= 1
    dscores /= X.shape[0]

    dW = np.dot(X.T, dscores)
    dW += reg*W 
    
    # compute the loss: average cross-entropy loss and regularization
    data_loss = np.sum(correct_logprobs)/num_examples
    reg_loss = 0.5*reg*np.sum(W*W)
    loss = data_loss + reg_loss
    # *****END OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

    return loss, dW
