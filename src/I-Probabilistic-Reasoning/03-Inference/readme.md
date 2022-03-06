Inference involves determining the probability of query variables given some evidence.


*  Exact inference can be done by computing the joint distribution over the variables, setting evidence, and marginalizing out any hidden variables.

*  Inference can be done efficiently in naive Bayes models, in which a single parent
variable affects many conditionally independent children.

*  The variable elimination algorithm can make exact inference more efficient by
marginalizing out variables in sequence.

*  Belief propagation represents another method for inference, in which information is iteratively passed between factors to arrive at a result.

*  Inference in a Bayesian network can be shown to be NP-hard through a reduction to the 3SAT problem, motivating the development of approximate
inference methods.

*  Approximate inference can be done by directly sampling from the joint distribution represented by a Bayesian network, but it may involve discarding many
samples that are inconsistent with the evidence.

*  Likelihood weighted sampling can reduce computation required for approximate inference by only generating samples that are consistent with the evidence
and weighting each sample accordingly.

*  Gibbs sampling generates a series of unweighted samples that are consistent
with the evidence and can greatly speed approximate inference.

*  Exact inference can be done efficiently through matrix operations when the
joint distribution is Gaussian.