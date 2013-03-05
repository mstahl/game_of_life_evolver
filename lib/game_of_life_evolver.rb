module GameOfLifeEvolver
  # Defaults
  VERSION = '0.1a'
  ## Chromosome parameters
  ORGANISM_WIDTH  = 16
  ORGANISM_HEIGHT = 16
  MAX_COMPLEXITY  = 64
  ## Evolution/simulation parameters
  POPULATION        = 10_000  # Constant number of organisms simulated
  GENERATIONS       = 100_000 # Length of simulation in generations
  MUTATION_PERCENT  = 25      # % of chromosomes to mutate each tick
  MUTATION_CHANCE   = 0.15    # Randomization threshold for mutations
  ATTRITION_PERCENT = 10      # % of chromosomes to kill each tick
  CROSSOVER_PERCENT = 10      # % of crossovers and corresponding births
end

Dir[File.join(File.dirname(__FILE__), 'game_of_life_evolver', '**', '*.rb')].each {|f| require f}
