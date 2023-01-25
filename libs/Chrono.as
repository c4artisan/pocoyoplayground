// Chrono.as

/****************************************************************************/
/*  CONSTRUCTOR																*/
/****************************************************************************/

Chrono=function()
{
    this.initial=-1;
    this.actual=-1;
    this.countdown=false;
    this.stopped=true;
    //
    this.timer_start=0;
    //
    this.setInitialTime(0,0,0,0);
}

Chrono.prototype.__class__="Chrono";

/****************************************************************************/
/*  PUBLIC METHODS                                                          */
/****************************************************************************/

// Asigna el tiempo inicial (y el actual si no ha sido asignado).
Chrono.prototype.setInitialTime=function(h,m,s,ms)
{
	this.initial=this.convertToMs(h,m,s,ms);
	if (this.actual==-1) this.actual=this.initial;
}

// Asigna el tiempo actual (y el inicial si no ha sido asignado).
Chrono.prototype.setTime=function(h,m,s,ms)
{
	this.timer_start=getTimer();
	this.actual=this.convertToMs(h,m,s,ms);
	if (this.initial==-1) this.initial=this.actual;
}

// Devuelve el tiempo actual.
Chrono.prototype.getTime=function()
{
	return this.actual;
}

// Devuelve las horas.
Chrono.prototype.getH=function()
{
	return int(this.actual/3600000);
}

// Devuelve los minutos.
Chrono.prototype.getM=function()
{
	return int((this.actual%3600000)/60000);
}

// Devuelve los segundos.
Chrono.prototype.getS=function()
{
	return int((this.actual%60000)/1000);
}

// Devuelve los milisegundos.
Chrono.prototype.getMs=function()
{
	return int(this.actual%1000);
}

// Activa.
Chrono.prototype.start=function()
{
	if (this.stopped&&this.initial!=-1)
	{
		this.timer_start=getTimer();
		this.stopped=false;
	}
}

// Para.
Chrono.prototype.stop=function()
{
	this.update();
	this.stopped=true;
}

// Devuelve si está parado.
Chrono.prototype.isStopped=function()
{
	return this.stopped;
}

// Reinicia el tiempo (no lo para).
Chrono.prototype.reset=function()
{
	this.timer_start=getTimer();
	this.actual=this.initial;
}

// Asigna el tipo de cronómetro (Normal-Cuenta atrás).
Chrono.prototype.setCountDown=function(countdown)
{
	this.countdown=countdown;
}

// Devuelve el tipo de cronómetro.
Chrono.prototype.isCountDown=function()
{
	return this.countdown;
}

// Actualiza el cronómetro (Debería ser llamada en un "onClipEvent(enterFrame)").
Chrono.prototype.update=function()
{
	if (this.initial!=-1&&!this.stopped)
	{
		// Retardo real.
		var delay=getTimer()-this.timer_start;
		this.timer_start=getTimer();
		// Actualiza el tiempo.
		if (this.countdown)
		{
			this.actual=Math.max(0,this.actual-delay);
			if (this.actual==0)
				 this.stopped=true;
		}
		else this.actual+=delay;
	}
}

/****************************************************************************/
/*  PRIVATE METHODS                                                         */
/****************************************************************************/

// Convierte un tiempo en ms.
Chrono.prototype.convertToMs=function(h,m,s,ms)
{
	return (h*3600000)+(m*60000)+(s*1000)+ms;
}


