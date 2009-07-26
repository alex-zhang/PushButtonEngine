package com.pblabs.engine.debug.log4PBE
{
   internal class LogLevel
   {
      public function LogLevel(name:String, level:int)
      {
         _name = name;
         _level = level;
      }
      
      public function get name():String
      {
         return _name;
      }
      
      public function compare(level:LogLevel):int
      {
         if (level._level < _level)
            return -1;
         
         if (level._level > _level)
            return 1;
         
         return 0;
      }
      
      private var _name:String;
      private var _level:int;
   }
}