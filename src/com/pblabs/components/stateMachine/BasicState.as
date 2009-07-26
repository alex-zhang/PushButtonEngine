package com.pblabs.components.stateMachine
{
   import com.pblabs.engine.core.*;
   import flash.events.*;
   
   /**
    * Simple state that allows for generic transition rules.
    * 
    * This tries each transition in order, and takes the first one that
    * evaluates to true and that succesfully changes state.
    * 
    * More complex state behavior can probably be derived from this class.
    */
   public class BasicState implements IState
   {
      /**
       * List of subclasses of ITransition that are evaluated to transition to
       * new states.
       */ 
      [TypeHint(type="com.pblabs.components.stateMachine.IState")]
      public var Transitions:OrderedArray = new OrderedArray();
      
      /**
       * If we want an event to be fired on the container when this state is
       * entered, it is specified here.
       */ 
      public var EnterEvent:String = null;
      
      public function addTransition(t:ITransition):void
      {
         Transitions.push(t);
      }
      
      public function tick(fsm:IMachine):void
      {
         // evaluate transitions in order until one goes.
         for each(var t:ITransition in Transitions)
         {
            //Logger.print(this, "Evaluating transition '" + t); 
            if(t.evaluate(fsm) && fsm.setCurrentState(t.getTargetState()))
               return;
         }
      }
      
      public function enter(fsm:IMachine):void
      {
         // Dispatch the enter event if we've got one.
         if(!EnterEvent)
            return;
         
         // And fire the event.
         var e:Event = new Event(EnterEvent);
         fsm.propertyBag.eventDispatcher.dispatchEvent(e);
      }
      
      public function exit(fsm:IMachine):void
      {
          // NOP.
      }
   }
}