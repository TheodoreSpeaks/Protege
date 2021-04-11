import time
import numpy as np
import scipy as sp
import hashlib as hl
import time as tm
import string as sn
import scipy.stats as st

class minHash: 
    #Sets class variables and starts generating signature of given file
    def __init__(self, text, n, k, comWords):
        self.text = text
        self.n = n  # Number of words per shingle (equal to two for the introductory example)
        self.k = k  # Number of hash values saved in signature -- the smallest k encountered are saved
        self.comWords = comWords
        self.load()
    
    #Attempts to load the file from the given filepath
    def load(self):
        self.signature = self.k*[float('inf')] #Builds a list with k elements equal to infinity
        translator = str.maketrans('', '', sn.punctuation)
        shingle = self.n*['']  # Initialize to list of n empty strings
        pointer = 0  # Points to location next word will go into the list shingle, it cycles modulo n
        full_flag=0  # Indicates whether at least n words have been read yet
        for word in self.text.split():
            word = word.translate(translator) #Removes punctuation
            word = word.lower() #Makes lower case
            if not (word in self.comWords): 
                shingle[pointer] = word
                if pointer==self.n-1: full_flag=1   # First happens just after the nth word is added to shingle
                pointer = (pointer+1)%self.n
                if full_flag==1: self.__updateSig__(shingle, pointer)            
    
    #Determines if the signature should be updated to include the hash value of the new shingle
    def __updateSig__(self, shingle, pointer):
        conShing = '' #Will become the string obtained by loading in words, beginning at pointer
        for i in range(pointer, np.size(shingle)):
            conShing = conShing + shingle[i]
        for i in range(pointer):
            conShing = conShing + shingle[i]
        h = int(hl.sha1(conShing.encode('utf8')).hexdigest(),base=16) #Hash function used in signature 
        
        if h<np.max(self.signature) and not (h in self.signature):  #Add new hash value to signature if it is smaller than the largest already there.
            i = np.argmax(self.signature) #Makes sure there are no duplicate values in signature
            self.signature[i] = h

#configuration parameters
n = 2
k = 20
com_words =  ('I', 'to', 'with', 'the', 'for', 'of', 'be', 'who', 'are', 'is', 'in', 'on', 'an', 'a', 'and', 'as')

#create function for calculating h_k(A U B), given h_k(A) and h_k(b)
def h_k(sig1, sig2):#take in 2 signatures
    union = np.concatenate((sig1, sig2))
    union = union[union != float('inf')]
    return union[union.argsort()[:k]] #return k smallest hashes in the two signatures
def compare(mh1signature, mh2signature):  #### Part 2 ####
    intersect = np.intersect1d(mh1signature, mh2signature) #intersect the two sig, aka h_k(A)h_k(B)
    intersect = intersect[intersect != float('inf')] #remove all empty entries
    cardinality = len(np.intersect1d(intersect, h_k(mh1signature, mh2signature))) #aka h_k(A U B)h_k(A)h_k(B)
    return cardinality/k

def get_sig(convo):
    return minHash(convo, n, k, com_words).signature

'''
mhA = minHash('documentA.txt', n, k, com_words)
mhB = minHash('documentB.txt', n, k, com_words)
mhC = minHash('documentC.txt', n, k, com_words)
print('Document A signature:', mhA.signature)
print('Document B signature:', mhB.signature)
print('Document C signature:', mhC.signature)


print("J(A,B) = {}".format(compare(mhA, mhB)))
print("J(C,B) = {}".format(compare(mhC, mhB)))
print("J(A,C) = {}".format(compare(mhA, mhC)))
print("Using the estimator of J, with k=10, A is similiarly equal to B and C. However increasing k, shows that A is infact most similiar to B")

#### Part 3 ####
print("As k increases, we are increasing the sample size of the estimator.  As in, within k randomly chosen shingles, how many match.  Therefore, increasing k will increase the precision of the estimator")
print("As n increase, the shingle size increases.  This means longer chunks of words will need to be the same for the shingles to match.  If you were to shuffle words around in a paragraph more, a lower n would be allow the shuffled paragraph to still be similiar.  Taken to extreme n=1, matches will occur for having the same word.  Taken to extreme n=len of document, the entire document would need to be the same")
'''
