import unittest

from rope.base import pyobjects, builtins
from ropetest import testutils


class BuiltinTypesTest(unittest.TestCase):

    def setUp(self):
        super(BuiltinTypesTest, self).setUp()
        self.project = testutils.sample_project()
        self.pycore = self.project.pycore
        self.mod = testutils.create_module(self.project, 'mod')

    def tearDown(self):
        testutils.remove_project(self.project)
        super(BuiltinTypesTest, self).tearDown()

    def test_simple_case(self):
        self.mod.write('l = []\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        self.assertTrue('append' in pymod['l'].get_object())

    def test_holding_type_information(self):
        self.mod.write('class C(object):\n    pass\nl = [C()]\na_var = l.pop()\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_get_items(self):
        self.mod.write('class C(object):\n    def __getitem__(self, i):\n        return C()\n'
                       'c = C()\na_var = c[0]')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_get_items_for_lists(self):
        self.mod.write('class C(object):\n    pass\nl = [C()]\na_var = l[0]\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_get_items_from_slices(self):
        self.mod.write('class C(object):\n    pass\nl = [C()]\na_var = l[:].pop()\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_simple_for_loops(self):
        self.mod.write('class C(object):\n    pass\nl = [C()]\n'
                       'for c in l:\n    a_var = c\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_definition_location_for_loop_variables(self):
        self.mod.write('class C(object):\n    pass\nl = [C()]\n'
                       'for c in l:\n    pass\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_var = pymod['c']
        self.assertEquals((pymod, 4), c_var.get_definition_location())

    def test_simple_case_for_dicts(self):
        self.mod.write('d = {}\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        self.assertTrue('get' in pymod['d'].get_object())

    def test_get_item_for_dicts(self):
        self.mod.write('class C(object):\n    pass\nd = {1: C()}\na_var = d[1]\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_popping_dicts(self):
        self.mod.write('class C(object):\n    pass\nd = {1: C()}\na_var = d.pop(1)\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_getting_keys_from_dicts(self):
        self.mod.write('class C1(object):\n    pass\nclass C2(object):\n    pass\n'
                       'd = {C1(): C2()}\nfor c in d.keys():\n    a_var = c\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C1'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_getting_values_from_dicts(self):
        self.mod.write('class C1(object):\n    pass\nclass C2(object):\n    pass\n'
                       'd = {C1(): C2()}\nfor c in d.values():\n    a_var = c\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C2'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_getting_iterkeys_from_dicts(self):
        self.mod.write('class C1(object):\n    pass\nclass C2(object):\n    pass\n'
                       'd = {C1(): C2()}\nfor c in d.keys():\n    a_var = c\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C1'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_getting_itervalues_from_dicts(self):
        self.mod.write('class C1(object):\n    pass\nclass C2(object):\n    pass\n'
                       'd = {C1(): C2()}\nfor c in d.values():\n    a_var = c\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C2'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_using_copy_for_dicts(self):
        self.mod.write('class C1(object):\n    pass\nclass C2(object):\n    pass\n'
                       'd = {C1(): C2()}\nfor c in d.copy():\n    a_var = c\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C1'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_tuple_assignments_for_items(self):
        self.mod.write('class C1(object):\n    pass\nclass C2(object):\n    pass\n'
                       'd = {C1(): C2()}\nkey, value = d.items()[0]\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c1_class = pymod['C1'].get_object()
        c2_class = pymod['C2'].get_object()
        key = pymod['key'].get_object()
        value = pymod['value'].get_object()
        self.assertEquals(c1_class, key.get_type())
        self.assertEquals(c2_class, value.get_type())

    def test_tuple_assignment_for_lists(self):
        self.mod.write('class C(object):\n    pass\nl = [C(), C()]\na, b = l\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        a_var = pymod['a'].get_object()
        b_var = pymod['b'].get_object()
        self.assertEquals(c_class, a_var.get_type())
        self.assertEquals(c_class, b_var.get_type())

    def test_tuple_assignments_for_iteritems_in_fors(self):
        self.mod.write('class C1(object):\n    pass\nclass C2(object):\n    pass\n'
                       'd = {C1(): C2()}\nfor x, y in d.items():\n    a = x;\n    b = y\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c1_class = pymod['C1'].get_object()
        c2_class = pymod['C2'].get_object()
        a_var = pymod['a'].get_object()
        b_var = pymod['b'].get_object()
        self.assertEquals(c1_class, a_var.get_type())
        self.assertEquals(c2_class, b_var.get_type())

    def test_simple_tuple_assignments(self):
        self.mod.write('class C1(object):\n    pass\nclass C2(object):\n    pass\n'
                       'a, b = C1(), C2()\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c1_class = pymod['C1'].get_object()
        c2_class = pymod['C2'].get_object()
        a_var = pymod['a'].get_object()
        b_var = pymod['b'].get_object()
        self.assertEquals(c1_class, a_var.get_type())
        self.assertEquals(c2_class, b_var.get_type())

    def test_overriding_builtin_names(self):
        self.mod.write('class C(object):\n    pass\nlist = C\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        list_var = pymod['list'].get_object()
        self.assertEquals(c_class, list_var)

    def test_simple_builtin_scope_test(self):
        self.mod.write('l = list()\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        self.assertTrue('append' in pymod['l'].get_object())

    def test_simple_sets(self):
        self.mod.write('s = set()\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        self.assertTrue('add' in pymod['s'].get_object())

    def test_making_lists_using_the_passed_argument_to_init(self):
        self.mod.write('class C(object):\n    pass\nl1 = [C()]\n'
                       'l2 = list(l1)\na_var = l2.pop()')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_making_tuples_using_the_passed_argument_to_init(self):
        self.mod.write('class C(object):\n    pass\nl1 = [C()]\n'
                       'l2 = tuple(l1)\na_var = l2[0]')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_making_sets_using_the_passed_argument_to_init(self):
        self.mod.write('class C(object):\n    pass\nl1 = [C()]\n'
                       'l2 = set(l1)\na_var = l2.pop()')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_making_dicts_using_the_passed_argument_to_init(self):
        self.mod.write('class C1(object):\n    pass\nclass C2(object):\n    pass\n'
                       'l1 = [(C1(), C2())]\n'
                       'l2 = dict(l1)\na, b = l2.items()[0]')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c1_class = pymod['C1'].get_object()
        c2_class = pymod['C2'].get_object()
        a_var = pymod['a'].get_object()
        b_var = pymod['b'].get_object()
        self.assertEquals(c1_class, a_var.get_type())
        self.assertEquals(c2_class, b_var.get_type())

    def test_range_builtin_function(self):
        self.mod.write('l = range(1)\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        l = pymod['l'].get_object()
        self.assertTrue('append' in l)

    def test_reversed_builtin_function(self):
        self.mod.write('class C(object):\n    pass\nl = [C()]\n'
                       'for x in reversed(l):\n    a_var = x\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_sorted_builtin_function(self):
        self.mod.write('class C(object):\n    pass\nl = [C()]\n'
                       'a_var = sorted(l).pop()\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_super_builtin_function(self):
        self.mod.write(
            'class C(object):\n    pass\n'
            'class A(object):\n    def a_f(self):\n        return C()\n'
            'class B(A):\n    def b_f(self):\n        return super(B, self).a_f()\n'
            'a_var = B.b_f()\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_file_builtin_type(self):
        self.mod.write('for line in open("file.txt"):\n    a_var = line\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        a_var = pymod['a_var'].get_object()
        self.assertTrue(isinstance(a_var.get_type(), builtins.Str))

    def test_property_builtin_type(self):
        self.mod.write('p = property()\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        p_var = pymod['p'].get_object()
        self.assertTrue('fget' in p_var)

    def test_lambda_functions(self):
        self.mod.write('l = lambda: 1\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        l_var = pymod['l'].get_object()
        self.assertEquals(pyobjects.get_base_type('Function'),
                          l_var.get_type())

    def test_lambda_function_definition(self):
        self.mod.write('l = lambda x, y = 2, *a, **b: x + y\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        l_var = pymod['l'].get_object()
        self.assertTrue(l_var.get_name() is not None)
        self.assertEquals(len(l_var.get_param_names()), 4)
        self.assertEquals((pymod, 1),
                          pymod['l'].get_definition_location())

    def test_lambdas_that_return_unknown(self):
        self.mod.write('a_var = (lambda: None)()\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        a_var = pymod['a_var'].get_object()
        self.assertTrue(a_var is not None)

    def test_builtin_zip_function(self):
        self.mod.write(
            'class C1(object):\n    pass\nclass C2(object):\n    pass\n'
            'c1_list = [C1()]\nc2_list = [C2()]\n'
            'a, b = zip(c1_list, c2_list)[0]')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c1_class = pymod['C1'].get_object()
        c2_class = pymod['C2'].get_object()
        a_var = pymod['a'].get_object()
        b_var = pymod['b'].get_object()
        self.assertEquals(c1_class, a_var.get_type())
        self.assertEquals(c2_class, b_var.get_type())

    def test_builtin_zip_function_with_more_than_two_args(self):
        self.mod.write(
            'class C1(object):\n    pass\nclass C2(object):\n    pass\n'
            'c1_list = [C1()]\nc2_list = [C2()]\n'
            'a, b, c = zip(c1_list, c2_list, c1_list)[0]')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c1_class = pymod['C1'].get_object()
        c2_class = pymod['C2'].get_object()
        a_var = pymod['a'].get_object()
        b_var = pymod['b'].get_object()
        c_var = pymod['c'].get_object()
        self.assertEquals(c1_class, a_var.get_type())
        self.assertEquals(c2_class, b_var.get_type())
        self.assertEquals(c1_class, c_var.get_type())

    def test_wrong_arguments_to_zip_function(self):
        self.mod.write(
            'class C1(object):\n    pass\nc1_list = [C1()]\n'
            'a, b = zip(c1_list, 1)[0]')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c1_class = pymod['C1'].get_object()
        a_var = pymod['a'].get_object()
        b_var = pymod['b'].get_object()
        self.assertEquals(c1_class, a_var.get_type())

    def test_enumerate_builtin_function(self):
        self.mod.write('class C(object):\n    pass\nl = [C()]\n'
                       'for i, x in enumerate(l):\n    a_var = x\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_builtin_class_get_name(self):
        self.assertEquals('object',
                          builtins.builtins['object'].get_object().get_name())
        self.assertEquals('property',
                          builtins.builtins['property'].get_object().get_name())

    def test_star_args_and_double_star_args(self):
        self.mod.write('def func(p, *args, **kwds):\n    pass\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        func_scope = pymod['func'].get_object().get_scope()
        args = func_scope['args'].get_object()
        kwds = func_scope['kwds'].get_object()
        self.assertTrue(isinstance(args.get_type(), builtins.List))
        self.assertTrue(isinstance(kwds.get_type(), builtins.Dict))

    def test_simple_list_comprehension_test(self):
        self.mod.write('a_var = [i for i in range(10)]\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        a_var = pymod['a_var'].get_object()
        self.assertTrue(isinstance(a_var.get_type(), builtins.List))

    def test_simple_list_generator_expression(self):
        self.mod.write('a_var = (i for i in range(10))\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        a_var = pymod['a_var'].get_object()
        self.assertTrue(isinstance(a_var.get_type(), builtins.Iterator))

    def test_iter_builtin_function(self):
        self.mod.write('class C(object):\n    pass\nl = [C()]\n'
                       'for c in iter(l):\n    a_var = c\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        c_class = pymod['C'].get_object()
        a_var = pymod['a_var'].get_object()
        self.assertEquals(c_class, a_var.get_type())

    def test_simple_int_type(self):
        self.mod.write('l = 1\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        self.assertEquals(builtins.builtins['int'].get_object(),
                          pymod['l'].get_object().get_type())

    def test_simple_float_type(self):
        self.mod.write('l = 1.0\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        self.assertEquals(builtins.builtins['float'].get_object(),
                          pymod['l'].get_object().get_type())

    def test_simple_float_type2(self):
        self.mod.write('l = 1e1\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        self.assertEquals(builtins.builtins['float'].get_object(),
                          pymod['l'].get_object().get_type())

    def test_simple_complex_type(self):
        self.mod.write('l = 1.0j\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        self.assertEquals(builtins.builtins['complex'].get_object(),
                          pymod['l'].get_object().get_type())

    def test_handling_unaryop_on_ints(self):
        self.mod.write('l = -(1)\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        self.assertEquals(builtins.builtins['int'].get_object(),
                          pymod['l'].get_object().get_type())

    def test_handling_binop_on_ints(self):
        self.mod.write('l = 1 + 1\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        self.assertEquals(builtins.builtins['int'].get_object(),
                          pymod['l'].get_object().get_type())

    def test_handling_compares(self):
        self.mod.write('l = 1 == 1\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        self.assertEquals(builtins.builtins['bool'].get_object(),
                          pymod['l'].get_object().get_type())

    def test_handling_boolops(self):
        self.mod.write('l = 1 and 2\n')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        self.assertEquals(builtins.builtins['int'].get_object(),
                          pymod['l'].get_object().get_type())


class BuiltinModulesTest(unittest.TestCase):

    def setUp(self):
        super(BuiltinModulesTest, self).setUp()
        self.project = testutils.sample_project(
            extension_modules=['time', 'invalid', 'invalid.sub'])
        self.pycore = self.project.pycore
        self.mod = testutils.create_module(self.project, 'mod')

    def tearDown(self):
        testutils.remove_project(self.project)
        super(BuiltinModulesTest, self).tearDown()

    def test_simple_case(self):
        self.mod.write('import time')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        self.assertTrue('time' in pymod['time'].get_object())

    def test_ignored_extensions(self):
        self.mod.write('import os')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        self.assertTrue('rename' not in pymod['os'].get_object())

    def test_ignored_extensions(self):
        self.mod.write('import os')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        self.assertTrue('rename' not in pymod['os'].get_object())

    def test_nonexistent_modules(self):
        self.mod.write('import invalid')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        pymod['invalid'].get_object()

    def test_nonexistent_modules(self):
        self.mod.write('import invalid\nimport invalid.sub')
        pymod = self.pycore.resource_to_pyobject(self.mod)
        invalid = pymod['invalid'].get_object()
        self.assertTrue('sub' in invalid)


def suite():
    result = unittest.TestSuite()
    result.addTests(unittest.makeSuite(BuiltinTypesTest))
    result.addTests(unittest.makeSuite(BuiltinModulesTest))
    return result


if __name__ == '__main__':
    unittest.main()
