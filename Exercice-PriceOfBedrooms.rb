### Classes
class BedPolicy
  ATTRIBUTES = [:maxNbPeople, :typeOfPerson]
  attr_accessor *ATTRIBUTES
  def initialize(bedType, typeOfPerson)
  @maxNbPeople = nbMaxPeople(bedType)
  @typeOfPerson = typeOfPerson
end

  def nbMaxPeople(bedType) #returns the number of max persons on initialization
    unless bedType == "double"
      return 1
    else
      return 2
    end
  end
end

class Bed
  ATTRIBUTES = [:name, :bedType, :price, :childPrice, :bedPolicy, :taken]
  attr_accessor *ATTRIBUTES

  def initialize(name, bedType, price, childPrice, typeOfPerson)
    @name = name
    @bedType = bedType
    @price = price
    @childPrice = childPrice
    @bedPolicy = BedPolicy.new(bedType, typeOfPerson)
    @taken = false
   end  

  def clone
    Bed.new(self.name, self.bedType, self.price, self.childPrice, self.bedPolicy)
  end
end

class PAX
  ATTRIBUTES = [:nbAdults, :nbChildren, :nbBabies]
  attr_accessor *ATTRIBUTES
  def initialize(nbAdults, nbChildren, nbBabies)
    @nbAdults = nbAdults
    @nbChildren = nbChildren
    @nbBabies = nbBabies
  end
end

          
### Functions
def associatePeopleToBeds(beds, typeOfPerson, numberOfPerson, price) 
#Core function to associate people too rooms
  while(numberOfPerson > 0)
    numberOfPersonAssociated = 0
    roomFound = false
    x = 0
    pricePart = 0
    #First checks if number of person is divisible by 2 => Give a double bed in priority
    if numberOfPerson % 2 != 0 && numberOfPerson != 0
      numberOfPersonAssociated = 1
      case typeOfPerson
        when "adult"
            pricePart = 50
            typeOfRoom = "guest"
          when "child"
            pricePart = 0
            typeOfRoom = "guest"
          when "baby"
            pricePart = 10
            typeOfRoom = "baby"
          end
        else
          numberOfPersonAssociated = 2
          typeOfRoom = "double"
          case typeOfPerson
            when "adult"
              pricePart = 100
            when "child"
              pricePart = 30
            end
          end
          #Principal allocation of people to rooms
          x = 0
          while x != beds[typeOfRoom].length && roomFound == false do
            if beds[typeOfRoom][x].taken == false
              beds[typeOfRoom][x].taken = true
              if x == 0 && typeOfRoom == "double"
                price += 0
              else
              price += pricePart
            end
            roomFound = true
            numberOfPerson -= numberOfPersonAssociated
            else
              x += 1
            end  
          end
        end
      return price, numberOfPerson
    end


	                
def VerifyPolicies(beds, pax) 
#Verifies if the current configuration could work. returns True or False
#Assuming that babies cannot have a larger bed and all other room can be occupied by Adults or Children
	maxNbAdultsAndChildren  = 0
	maxNbBabies = 0
	nbBedsLeft   = 0
	#Go through the different types of rooms, then the different rooms
	beds.each do |key, value|
	   beds[key].each do |value|
	     nbBedsLeft += 1
	     index = 0
	     if beds[key][index].bedPolicy.typeOfPerson.include?('adults') && beds[key][index].bedPolicy.typeOfPerson.include?('children') 
	        maxNbAdultsAndChildren += beds[key][index].bedPolicy.maxNbPeople
	     end
	     if(beds[key][index].bedPolicy.typeOfPerson.include? "baby")
	        maxNbBabies += beds[key][index].bedPolicy.maxNbPeople
	     end
	     index += 1
	    end
	end
	if(pax.nbBabies > maxNbBabies )
	  return false
	end
	return true
end
              
    
def ComputePrice(beds, pax)
	nbAdults = pax.nbAdults
	nbChildren = pax.nbChildren
	nbBabies = pax.nbBabies
	puts "(#{nbAdults},#{nbChildren},#{nbBabies}) =>"
	price = 0
	if VerifyPolicies(beds, pax) == false
	  return "Impossible configuration"
	else
	  while(nbAdults + nbChildren + nbBabies != 0)
	    if nbAdults != 0
	      price, nbAdults = associatePeopleToBeds(beds, "adult", nbAdults, price)
	    end
		if nbChildren != 0
		  price, nbChildren = associatePeopleToBeds(beds, "child", nbChildren, price)
		end
	    
		if nbBabies != 0
		price, nbBabies = associatePeopleToBeds(beds, "baby", nbBabies, price)
		end
	end
return "#{price}"
  end                
end                 
      

###Initialization    / 	Variables              
pax200 = PAX.new(2,0,0);
pax210 = PAX.new(2,1,0);
pax201 = PAX.new(2,0,1);
pax310 = PAX.new(3,1,0);
pax410 = PAX.new(4,1,0);
pax501 = PAX.new(5,0,1);
pax221 = PAX.new(2,2,1);
pax320 = PAX.new(3,2,0);
pax150 = PAX.new(1,5,0);
pax202 = PAX.new(2,0,2);

bed1 = Bed.new("Bed1", "double", 0, 30, ["adults", "children"])
bed2 = Bed.new("Bed2", "double", 100, 30, ["adults", "children"])
bed3 = Bed.new("Bed3", "guest", 50, 0, ["adults", "children"])
bed4 = Bed.new("Bed4", "guest", 50, 0, ["adults", "children"])
bed5 = Bed.new("Bed5", "baby", 10, 0, ["baby"]) 

testSet = [
  pax200,
  pax210,
  pax201,
  pax310,
  pax410,
  pax501,
  pax221,
  pax320,
  pax150,
  pax202
]

testSet.each {|pax|
	#Deep copies destroyed after their use
 	copyBed1 = Marshal.load(Marshal.dump(bed1))
  	copyBed2 = Marshal.load(Marshal.dump(bed2))
  	copyBed3 = Marshal.load(Marshal.dump(bed3))
  	copyBed4 = Marshal.load(Marshal.dump(bed4))
  	copyBed5 = Marshal.load(Marshal.dump(bed5))

  beds = {
  "double" => [copyBed1,copyBed2],
  "guest" => [copyBed3,copyBed4],
  "baby" => [copyBed5]
  }  
  puts "#{ComputePrice(beds, pax)} "   
}
                                  