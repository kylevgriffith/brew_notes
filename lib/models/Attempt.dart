// Attempts represent each time a user tries to make a recipe.
// Should record a start date automatically as well as time of notes/temps.
// List of temps should be able to be added to until end date is set.
// List of notes should be able to be changed at any time.
class Attempt {
  DateTime start;
  DateTime? end;
  num rating;
  num abv;
  var temps = <DateTime, num>{};
  // hydrometer readings
  var readings = <DateTime, num>{};
  var notes = <String>[];

  Attempt(this.start, this.rating, this.abv);

  addTemp(DateTime time, num temp) {
    this.temps[time] = temp;
  }

  addReading(DateTime time, num value, num temp) {
    this.readings[time] = value;
    this.abv = calcAbv(value, temp);
  }

  addNote(DateTime time, String note) {
    String result = 'Taken at $time\n$note';
    notes.add(result);
  }

  // calculate Alcohol By Volume from hydrometer reading
  // TODO: find actual formula, (temp is important)
  num calcAbv(num read, num temp) {
    return read * 2;
  }
}
