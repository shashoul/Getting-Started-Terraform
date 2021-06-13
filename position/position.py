class Position:


    def __init__(self, latitude, longitude):
        if not(-90 <= latitude <= +90):
            raise ValueError(f'Latitude {latitude} out of range')
        if not(-180 <= longitude <= +180):
            raise ValueError(f'Longitude {longitude} out of range')
        self._latitude = latitude
        self._longitude = longitude


    @property
    def latitude(self):
        return self._latitude


    @property
    def longitude(self):
        return self._longitude


    def __repr__(self):
        # return f'{self.__class__.__name__}(latitide={self.latitude}, longitude={self.longitude})'
        return f'{type(self).__name__}(latitide={self.latitude}, longitude={self.longitude})'


    def __str__(self):
        return f'{self.latitude} S, {self.longitude} E'


class EarthPosition(Position):
    pass


class MarsPosition(Position):
    pass



def typename(obj):
    return type(obj).__name__