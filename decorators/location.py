import inspect


def auto_repr(my_class):
    print(f'Decorating {my_class.__name__} with auto_repr')
    
    members = vars(my_class)

    for name, member in members.items():
        print(name, member)

    if '__repr__' in members:
        raise TypeError(f'{my_class.__name__} already defines __repr__')

    if '__init__' not in members:
        raise TypeError(f'{my_class.__name__} does not override __init__')

    sig = inspect.signature(my_class.__init__)
    parameters_names = list(sig.parameters)[1:]
    print('__init__ parameters names:',parameters_names)

    if not all(
        isinstance(members.get(name,None),property) 
        for name in parameters_names
    ):
        raise TypeError(f'Cannot apply auto_repr to {my_class.__name__} because not all __init__ parameters have matching properties')
    
    def synthesized_repr(self):
        return "{typename}({args})".format(
            typename=type(self).__name__,
            args=", ".join(
                "{name}={value!r}".format(
                    name=name,
                    value=getattr(self, name)
                ) for name in parameters_names
            )
        )

    setattr(my_class, "__repr__", synthesized_repr)

    return my_class


@auto_repr
class Location:

    def __init__(self, name, position):
        self._name = name
        self._position = position


    @property
    def name(self):
        return self._name


    @property
    def position(self):
        return self._position


    def __str__(self):
        return self.name