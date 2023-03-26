import traceback

import fluent.event
import fluent.sender


def simulate_error():
    fluent.sender.setup('myapp', host='localhost', port=24224)

    def report(ex):
        data = {}
        data['message'] = '{0}'.format(ex)
        data['serviceContext'] = {'service': 'myapp'}
        # ... add more metadata
        fluent.event.Event('errors', data)

    # report exception data using:
    try:
        # simulate calling a method that's not defined
        raise NameError
    except Exception:
        report(traceback.format_exc())
# [END error_reporting_fluent_on_compute]


if __name__ == '__main__':
    simulate_error()
