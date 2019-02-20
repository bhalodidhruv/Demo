trigger CT_Trigger on Contact (after update) {
    Long startingTime = System.now().getTime(); // Num milliseconds since Jan 1 1970
    Integer delayInMilliseconds = 40000; // One-second delay
    while (System.now().getTime() - startingTime < delayInMilliseconds)  {
                // Do nothing until desired delay has passed
     }
}